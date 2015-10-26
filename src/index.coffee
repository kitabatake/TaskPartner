$( ->

  appView = new AppView({
    el: $('div.app')
  })

  appView.collection.each (card) ->
    card.memos.fetch()
)