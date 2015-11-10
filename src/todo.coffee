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
    'click .toggle-todo' : 'toggleDone',
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

    this

  toggleDone: ->
    @model.toggle()
})