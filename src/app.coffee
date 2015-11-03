@AppView = Backbone.View.extend({
  events: {
    'submit .add-card': 'addCard'
  }
  initialize: ->
    @cards = new Cards()

    @cards.bind 'add', (card) =>
      cardOutlineView = new CardOutlineView({
        model: card
        $parentEl: @$cards
      })
      cardOutlineView.render()

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
      error:  ->
    }

  addCard: (e) ->
    e.preventDefault()

    newCard = @cards.create(
      {title: @$title.val()}
      {
        validate: true
        success: (model, results) ->
          model.updateUrl()
      }
    )

    if newCard
      @$title.val ''
      @$error.html ''

  deleteCard: (card) ->
    @cards.remove card
    
})