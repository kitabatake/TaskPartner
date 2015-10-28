@Memo = Backbone.Model.extend({
  defaults: {
    card_id: null
    content: ''
  }
})

@Memos = Backbone.Collection.extend({
  model: Memo,
  initialize: (models, options) -> 
    @card = options.card
    @localStorage =  new Backbone.LocalStorage("TaskPartner-memos-" + @card.id)

    @card.on 'destroy', (card) =>
      while memo = @first()
        memo.destroy()
})

@MemoView = Backbone.View.extend({
  tagName: 'div'
  initialize: ->
    @template = _.template $('#memo-view-template').html()
    @listenTo @model, 'destroy', @remove

  render: ->
    @$el.html @template @model.toJSON()
    this
})