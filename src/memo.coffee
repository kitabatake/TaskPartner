@Memo = Backbone.Model.extend({
  defaults: {
    card_id: ''
    content: ''
  }
})

@Memos = Backbone.Collection.extend({
  model: Memo,
  initialize: (models, options) -> 
    @card = options.card
    @localStorage =  new Backbone.LocalStorage("TaskPartner-memos-" + @card.id)
})

@MemoView = Backbone.View.extend({
  tagName: 'div'
  initialize: ->
    @template = _.template $('#memo-view-template').html()

  render: ->
    @$el.html @template @model.toJSON()
    this
})