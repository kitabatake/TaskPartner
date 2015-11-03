@Memo = Backbone.Model.extend({
  url: 'http://localhost:3000/cards/'
  defaults: {
    card_id: null
    content: ''
  }
  initialize: (attrs) ->
    @url += attrs.card_id + '/memos/'
    @url += @id if @id
})

@Memos = Backbone.Collection.extend({
  model: Memo,
  url: 'http://localhost:3000/cards/'
  parse: (res) ->
    res

  initialize: (models, options) ->
    @url += options.card.id + '/memos'
})

@MemoView = Backbone.View.extend({
  tagName: 'div'
  initialize: (attrs) ->
    @template = _.template Templates.memoView
    @$parentEl = attrs.$parentEl

  render: ->
    @$el.html @template {
      content: @model.get('content').replace(/[\r\n?]/g, '<br />')
    }
    @$parentEl.prepend @$el
    this
})