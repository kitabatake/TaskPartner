
@Card = Backbone.Model.extend({
  url: 'http://localhost:3000/cards/'
  defaults: {
    title: ''
    created: null #Moment object
  }
  initialize: (attrs) ->

    @updateUrl()
    @memos = new Memos([], {card: this})
    @memos.fetch()
    @set 'created', moment(attrs.created_at)


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

  updateUrl: ->
    @url += @id if @id and /\/$/.test @url
})

@Cards = Backbone.Collection.extend({
  model: Card
  url: 'http://localhost:3000/cards'
  parse: (res) ->
    res

})

@CardOutlineView = Backbone.View.extend({
  tagName: 'div'
  events: {
    'click .card-outline': 'openCardView'
  }
  initialize: (attrs) ->
    @template = _.template Templates.cardOutlineView
    @listenTo @model, 'destroy', @remove
    @$parentEl = attrs.$parentEl

  render: ->
    @$el.html @template @model.toJSON()
    @$parentEl.prepend @$el
    this
 
  openCardView: (e) ->
    e.preventDefault()

    cardView = new CardView {
      model: @model
      $parentEl: $('body')
    }
    
    cardView.render()
})

@CardView = Backbone.View.extend({
  tagName: 'div'
  events: {
    'click .card-close': 'closeCardView'
    'click .card-delete-btn': 'deleteCard'
    'click .memo-add-btn': 'addMemo'
  }
  modalOptions: {
    backdrop: true
  }
  initialize: (attrs) ->
    @template = _.template Templates.cardView
    @$parentEl = attrs.$parentEl
    
    @model.memos.bind 'add', (memo) =>
      memoView = new MemoView {
        model: memo
        $parentEl: @$memos
      }
      memoView.render()

  render: ->
    @$el.html @template _.extend(
      @model.toJSON(),
      {
        created: @model.displayDate()
      }
    )

    @$parentEl.append @$el
    @$modal = @$el.find "#card-" + @model.id
    @$memos = @$el.find '.memos'
    @$memoContentInput = @$el.find '.memo-content-input'

    @model.memos.each (memo) =>
      memoView = new MemoView {
        model: memo
        $parentEl: @$memos
      }
      memoView.render()

    @$modal.modal(@modalOptions)
    this

  closeCardView: (e) ->
    @$modal.on 'hidden.bs.modal', (e) =>
      $(@$el).remove

    @$modal.modal('hide')
 
  deleteCard: (e) ->
    e.preventDefault()
    @closeCardView()
    @model.destroy()

  addMemo: (e) ->
    e.preventDefault()
    newMemo = @model.memos.create({
      card_id: @model.get 'id'
      content: @$memoContentInput.val()
    })

    if newMemo
      @$memoContentInput.val('')
      memoView = new MemoView {
        model: newMemo
        $parentEl: @$memos
      }
      memoView.render()

})


