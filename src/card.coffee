
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
  
  events: {
    'click .delete-card': 'deleteCard'
  }
  
  initialize: ->
    @template = _.template($('#card-view-template').html())
    @model.on 'destroy', @remove, this

  render: ->
    html = @template(this.model.toJSON())
    @$el.html html
    return this;
  
  deleteCard: (e) ->
    e.preventDefault()
    @model.destroy()
})

@AppView = Backbone.View.extend({
  events: {
    'submit .add-card': 'addCard'
  }

  initialize: ->
    @$title = @$el.find('input.card-title-input')
    @$cardList = @$el.find('.cards')
    @$error = @$el.find('.add-card-error')
    
    @collection.on 'add', (card) => 
        newCardView = new CardView {model: card}
        @$cardList.prepend newCardView.render().el
    
    @collection.on 'invalid', (card, errors) =>
      @$error.html errors[0]['message']

  addCard: (e) ->
    e.preventDefault()

    newCard = this.collection.create(
      {title: @$title.val()}
      {validate: true}
    )

    if newCard
      @$title.val ''
      @$error.html ''
    
})

