@AppView = Backbone.View.extend({
  events: {
    'click .add-card-group-btn': 'addCardGroup'
  }
  initialize: ->
    @cardGroups = new CardGroups()

    @cardGroups.bind 'add', (cardGroup) =>
      cardGroupView = new CardGroupView({
        model: cardGroup
        $parentEl: @$cards
      })
      cardGroupView.render()

    @$title = @$el.find 'input.card-group-title-input'
    @$cards = @$el.find '.card-groups'

    @cardGroups.fetch {
      data:{}
      success: (collection, res, options) ->
      error:  ->
    }

  addCardGroup: (e) ->
    e.preventDefault()

    cardGroup = @cardGroups.create(
      {title: @$title.val()}
      {
        validate: true
        success: (model, results) ->
          model.updateUrl()
      }
    )

    if cardGroup
      @$title.val ''
    
})