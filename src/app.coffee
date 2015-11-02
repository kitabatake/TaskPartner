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
    @cards.fetch {
      data:{
        created_at_from: moment().format('YYYY-MM-DD')
      }
      success: (collection, res, options) ->
        console.log res
        console.log collection
      error: (a, b, c) ->
        console.log 'error'
        console.log b
    }

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