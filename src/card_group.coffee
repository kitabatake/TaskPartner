
@CardGroup = Backbone.Model.extend({
  url: 'http://localhost:3000/card_groups/'
  defaults: {
    title: ''
    created: null #Moment object
  }
  initialize: (attrs) ->

    @updateUrl()
    @cards = new Cards([], {cardGroup: this})

    if @id 
      @cards.fetch(
        data:{
          card_group_id: @id
        }
      )

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

@CardGroups = Backbone.Collection.extend({
  model: CardGroup
  url: 'http://localhost:3000/card_groups'
  parse: (res) ->
    res
})

@CardGroupView = Backbone.View.extend({
  tagName: 'div'
  events: {
    'click .add-card-btn': 'addCard'
    'submit .card-title-input': 'addCard'
  }
  initialize: (attrs) ->
    @template = _.template $('#card-group-view-template').html()
    @$parentEl = attrs.$parentEl

    @model.cards.bind 'add', (card) =>
      cardOutlineView = new CardOutlineView({
        model: card
        $parentEl: @$cards
      })
      cardOutlineView.render()

    #@listenTo Card, 'destroy', @deleteCard

  render: ->
    @$el.html @template @model.toJSON()
    @$parentEl.prepend @$el
    @$cards = @$el.find '.cards'
    @$cardTitleInput = @$el.find 'input.card-title-input'

    this

  addCard: (e) ->
    e.preventDefault()

    card = @model.cards.create(
      {
        card_group_id: @model.id
        title: @$cardTitleInput.val()
      }
      {
        validate: true
        success: (model, results) ->
          model.updateUrl()
      }
    )

    if card
      @$cardTitleInput.val ''

})