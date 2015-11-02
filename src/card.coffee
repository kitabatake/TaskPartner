
@Card = Backbone.Model.extend({
  defaults: {
    title: ''
    created: null
  }
  initialize: (attrs) ->
    @set @idAttribute, _.uniqueId()
    @set 'createdDate', new Date(attrs.created)
    @memos = new Memos([], {card: this})

    console.log this.toJSON()

  validate: (attrs) ->
    
    errors = []
    if _.isEmpty(attrs.title)
      errors.push {
        attr: 'title'
        message: 'title is required'
      }

    if _.isEmpty(errors) then false else errors

  displayDate: ->
     @get('created').format('MM / DD')

})


@Cards = Backbone.Collection.extend({
  model: Card
  localStorage: new Backbone.LocalStorage("TaskPartner-cards")
})


@CardView = Backbone.View.extend({
  tagName: 'div'
  events: {
    'click .card-delete-btn': 'deleteCard',
    'click .memo-add-btn': 'addMemo'
  }
  initialize: ->
    @template = _.template $('#card-view-template').html()
    @listenTo @model, 'destroy', @remove

    @model.memos.bind 'add', (memo) =>
      memoView = new MemoView({model: memo})
      @$memos.append memoView.render().el

  render: ->
    @$el.html @template _.extend(
      @model.toJSON(),
      {
        created: @model.displayDate()
      }
    )

    @$memos = @$el.find '.memos'
    @$memoContentInput = @$el.find '.memo-content-input'
    this
 
  deleteCard: (e) ->
    e.preventDefault()
    @model.destroy()

  addMemo: (e) ->
    e.preventDefault()
    newMemo = @model.memos.create({
      card_id: @model.get 'id'
      content: @$memoContentInput.val()
    })

    if newMemo
      @$memoContentInput.val('')

})


