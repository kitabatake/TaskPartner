@Todo = Backbone.Model.extend({
  defaults: {
    card_id: null
    done: false
    content: ''
  }

  url: ->
    url = 'http://localhost:3000/cards/' + @get('card_id') + '/todos/'
    url += @id if @id
    url

  initialize: (attrs) ->

  toggle: ->
    @save({
      done: !@get('done')
    })
})

@Todos = Backbone.Collection.extend({
  model: Todo,
  url: ->
    'http://localhost:3000/cards/' + @card.id + '/todos'

  initialize: (models, options) ->
    @card = options.card
})

@TodoView = Backbone.View.extend({
  tagName: 'div'
  events: {
    'click .toggle-todo': 'toggleDone'
    'click .todo-content': 'changeEditMode'
    'click .todo-edit-btn': 'editTodo'
    'click .todo-delete-btn': 'deleteTodo' 
  }
  initialize: (attrs) ->
    @template = _.template $('#todo-view-template').html()
    @$parentEl = attrs.$parentEl

  render: ->

    @$el.html @template _.extend(
      @model.toJSON()
      {content: @model.get('content').replace(/[\r\n?]/g, '<br />')}
    )

    if !@$el.parent().length
      @$parentEl.prepend @$el
      @$displayArea = @$el.find '.todo-display-area'
      @$editArea = @$el.find '.todo-edit-area'

    this

  toggleDone: ->
    @model.toggle()

  changeEditMode: (e) ->
    e.preventDefault()
    @$displayArea.hide()
    @$editArea.show()

  editTodo: ->
    todoContent = @$el.find('.todo-content-edit-input').val()
    @model.save({
      content: todoContent
    })
    @$el.find('.todo-content').html(todoContent)
    @$displayArea.show()
    @$editArea.hide()

  deleteTodo: ->
    @model.destroy()
    @$el.remove()

})