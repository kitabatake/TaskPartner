
@Card = Backbone.Model.extend({
  defaults: {
    title: ''
  }
  sync: ->
  validate: (attrs) ->
    
    errors = []
    if _.isEmpty(attrs.title)
      errors.push {
        attr: 'title'
        message: 'title is required'
      }

    if _.isEmpty(errors) then false else errors
})

@Cards = Backbone.Collection.extend({
  model: Card
})

@CardView = Backbone.View.extend({
  tagName: 'div'
  collection: new Memos
  events: {
    'click .card-delete-btn': 'deleteCard',
    'click .memo-add-btn': 'addMemo'
  }
  initialize: ->
    @template = _.template $('#card-view-template').html()
    @model.on 'destroy', @remove, this

    @collection.bind 'add', (memo) =>
      memoView = new MemoView({model: memo})
      @$memos.prepend memoView.render().el

  render: ->
    @$el.html @template @model.toJSON()
    @$memos = @$el.find '.memos'
    @$memoContentInput = @$el.find '.memo-content-input'
    this
 
  deleteCard: (e) ->
    e.preventDefault()
    @model.destroy()

  addMemo: (e) ->
    e.preventDefault()
    newMemo = @collection.create({
      content: @$memoContentInput.val()
    })

    if newMemo
      @$memoContentInput.val('')

})

@AppView = Backbone.View.extend({
  collection: new Cards()
  events: {
    'submit .add-card': 'addCard'
  }
  initialize: ->
    @collection.bind 'add', (card) =>
      cardView = new CardView({model: card})
      @$cards.prepend cardView.render().el

    @$title = @$el.find 'input.card-title-input'
    @$cards = @$el.find '.cards'
    @$error = @$el.find '.add-card-error'
    
    @collection.on 'invalid', (card, errors) =>
      @$error.html errors[0]['message']

  addCard: (e) ->
    e.preventDefault()

    newCard = @collection.create(
      {title: @$title.val()}
      {validate: true}
    )

    if newCard
      @$title.val ''
      @$error.html ''

})

