@Memo = Backbone.Model.extend({
  defaults: {
    content: ''
  }
  sync: ->
})

@Memos = Backbone.Collection.extend({
  model: Memo
})

@MemoView = Backbone.View.extend({
  tagName: 'div'
  initialize: ->
    @template = _.template $('#memo-view-template').html()

  render: ->
    @$el.html @template @model.toJSON()
    this
})