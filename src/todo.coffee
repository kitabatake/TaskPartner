@Todo = Backbone.Model.extend({
  url: 'http://localhost:3000/cards/'
  defaults: {
    card_id: null
    done: false
    content: ''
  }
  initialize: (attrs) ->
    @url += attrs.card_id + '/todos/'
    @url += @id if @id

  toggle: ->
    @save({
      done: !@get('done')
    })

})

@Todos = Backbone.Collection.extend({
  model: Todo,
  url: 'http://localhost:3000/cards/'
  parse: (res) ->
    res

  initialize: (models, options) ->
    @url += options.card.id + '/todos'
})

@TodoView = Backbone.View.extend({
  tagName: 'div'
  events: {
    'click .toggle-todo': 'toggleDone'
    'dblclick .todo-content': 'changeEditMode'
    'click .todo-edit-btn': 'editTodo'
    'click .todo-delete-btn': 'deleteTodo' 
  }
  initialize: (attrs) ->
    @template = _.template $('#todo-view-template').html()
    @$parentEl = attrs.$parentEl

    @listenTo(@model, 'change', @render)

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