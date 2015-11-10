@Memo = Backbone.Model.extend({
  url: 'http://localhost:3000/cards/'
  defaults: {
    card_id: null
    content: ''
    created: null #Moment object
  }
  initialize: (attrs) ->
    @url += attrs.card_id + '/memos/'
    @url += @id if @id
    @set 'created', moment(attrs.created_at)

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
  events: {
    'dblclick .memo-content' : 'changeEditMode',
    'click .memo-edit-btn' : 'editMemo',
  }

  initialize: (attrs) ->
    @template = _.template $('#memo-view-display-template').html()
    @$parentEl = attrs.$parentEl

  render: ->
    @$el.html @template _.extend(
      @model.toJSON()
      {content: @model.get('content').replace(/[\r\n?]/g, '<br />')}
    )
    @$parentEl.prepend @$el
    this

  changeEditMode: ->
    @template = _.template $('#memo-view-edit-template').html()
    @render()

  editMemo: ->
    console.log @$el
    console.log @$el.find('.memo-content-edit').val()
    @model.save({
      content: @$el.find('.memo-content-edit').val()
    })
    @template = _.template $('#memo-view-display-template').html()
    @render()
})