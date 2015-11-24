@Memo = Backbone.Model.extend({
  defaults: {
    card_id: null
    content: ''
    created: null #Moment object
  }

  url: ->
    url = 'http://localhost:3000/cards/' + @get('card_id') + '/memos/'
    url += @id if @id
    url

  initialize: (attrs) ->
    @set 'created', moment(attrs.created_at)
})

@Memos = Backbone.Collection.extend({
  model: Memo,
  url: ->
    'http://localhost:3000/cards/' + @card.id + '/memos/'

  initialize: (models, options) ->
    @card = options.card
})

@MemoView = Backbone.View.extend({
  tagName: 'div'
  events: {
    'dblclick .memo-content' : 'changeEditMode',
    'click .memo-edit-btn' : 'editMemo'
    'click .memo-delete-btn' : 'deleteMemo'
  }

  initialize: (attrs) ->
    @template = _.template $('#memo-view-template').html()
    @$parentEl = attrs.$parentEl

  render: ->
    @$el.html @template _.extend(
      @model.toJSON()
      {content: @model.get('content').replace(/[\r\n?]/g, '<br />')}
    )
    @$parentEl.prepend @$el
    @$memoContent = @$el.find '.memo-content'
    @$editArea = @$el.find '.memo-content-edit-area'
    this

  changeEditMode: ->
    @$memoContent.hide()
    @$editArea.show()

  editMemo: ->
    memoContent = @$el.find('.memo-content-edit-input').val()
    @model.save({
      content: memoContent
    })
    @$memoContent.html(memoContent).show()
    @$editArea.hide()

  deleteMemo: ->
    @model.destroy()
    @$el.remove()
})