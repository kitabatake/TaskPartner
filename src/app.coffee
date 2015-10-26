@AppView = Backbone.View.extend({
  events: {
    'submit .add-card': 'addCard'
  }
  initialize: ->
    @cards = new Cards()
    @cards.bind 'add', (card) =>
      cardView = new CardView({model: card})
      @$cards.prepend cardView.render().el

    @$title = @$el.find 'input.card-title-input'
    @$cards = @$el.find '.cards'
    @$error = @$el.find '.add-card-error'
    
    @cards.on 'invalid', (card, errors) =>
      @$error.html errors[0]['message']


    @listenTo Card, 'destroy', @deleteCard
    @cards.fetch()

  addCard: (e) ->
    e.preventDefault()

    newCard = @cards.create(
      {title: @$title.val()}
      {validate: true}
    )

    if newCard
      @$title.val ''
      @$error.html ''

  deleteCard: (card) ->
    @cards.remove card
    console.log @cards.length
    
})