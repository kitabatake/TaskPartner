
@Card = Backbone.Model.extend({
  url: 'http://localhost:3000/cards/'
  defaults: {
    title: ''
    description: ''
    created: null #Moment object
  }
  initialize: (attrs) ->

    @updateUrl()
    @memos = new Memos([], {card: this})
    @memos.fetch()

    @todos = new Todos([], {card: this})
    @todos.fetch()
    @set 'created', moment(attrs.created_at)


  validate: (attrs) ->
    
    errors = []
    if _.isEmpty(attrs.title)
      errors.push {
        attr: 'title'
        message: 'title is required'
      }

    if _.isEmpty(errors) then false else errors

  updateUrl: ->
    @url += @id if @id and /\/$/.test @url
})

@Cards = Backbone.Collection.extend({
  model: Card
  url: 'http://localhost:3000/cards'
  parse: (res) ->
    res

})

@CardOutlineView = Backbone.View.extend({
  tagName: 'div'
  events: {
    'click .card-outline': 'openCardView'
  }
  initialize: (attrs) ->
    @template = _.template $('#card-outline-view-template').html()
    @listenTo @model, 'destroy', @remove
    @$parentEl = attrs.$parentEl

  render: ->
    @$el.html @template @model.toJSON()
    @$parentEl.prepend @$el
    this
 
  openCardView: (e) ->
    e.preventDefault()

    cardView = new CardView {
      model: @model
      $parentEl: $('body')
    }
    
    cardView.render()
})

@CardView = Backbone.View.extend({
  tagName: 'div'
  events: {
    'click .card-close': 'closeCardView'
    'click .card-delete-btn': 'deleteCard'
    'click .memo-add-btn': 'addMemo'
    'click .todo-add-btn': 'addTodo'
    'click .card-description-edit-btn': 'editDescription'
    'click .card-description-save-btn': 'saveDescription'
  }
  modalOptions: {
    backdrop: true
  }
  initialize: (attrs) ->
    @template = _.template $('#card-view-template').html()
    @$parentEl = attrs.$parentEl

  render: ->

    descriptionMarked = ''
    descriptionMarked = marked(@model.get('description')) if @model.get('description')

    @$el.html @template _.extend @model.toJSON()

    if !@$el.parent().length
      @$parentEl.append @$el
      @initElements();
      @renderRelations()
      @$modal.modal(@modalOptions)
    
    return this

  initElements: ->
    @$modal = @$el.find "#card-" + @model.id
    @$memos = @$el.find '.memos'
    @$memoContentInput = @$el.find '.memo-content-input'

    @$todos = @$el.find '.todos'
    @$todoContentInput = @$el.find '.todo-content-input'

    @$descriptionEditArea = @$el.find '.description-edit-area'
    @$descriptionViewArea = @$el.find '.description-view-area'
    @$descriptionEditArea.hide()


  renderRelations: ->

    @model.memos.each (memo) =>
      memoView = new MemoView {
        model: memo
        $parentEl: @$memos
      }
      memoView.render()

    @model.todos.each (todo) =>
      todoView = new TodoView {
        model: todo
        $parentEl: @$todos
      }
      todoView.render()


  closeCardView: (e) ->
    @$modal.on 'hidden.bs.modal', (e) =>
      $(@$el).remove

    @$modal.modal('hide')
 
  deleteCard: (e) ->
    e.preventDefault()
    @closeCardView()
    @model.destroy()

  addMemo: (e) ->
    e.preventDefault()
    newMemo = @model.memos.create({
      card_id: @model.get 'id'
      content: @$memoContentInput.val()
    })

    if newMemo
      @$memoContentInput.val('')
      memoView = new MemoView {
        model: newMemo
        $parentEl: @$memos
      }
      memoView.render()

  addTodo: (e) ->
    e.preventDefault()
    newTodo = @model.todos.create({
      card_id: @model.get 'id'
      content: @$todoContentInput.val()
    })

    if newTodo
      @$todoContentInput.val('')
      todoView = new TodoView {
        model: newTodo
        $parentEl: @$todos
      }
      todoView.render()

  editDescription: (e) ->
    e.preventDefault()
    @toggleDescriptionArea()

  saveDescription: (e) ->
    e.preventDefault()

    description = @$el.find('.card-description-input').val()
    @model.save {description: description}
    @$descriptionViewArea.find('.card-description').html marked(description)
    @toggleDescriptionArea()

  toggleDescriptionArea: ->
    @$descriptionViewArea.toggle()
    @$descriptionEditArea.toggle()

})


