moment.locale('ja')

$( ->
  #After DOM rendering processing
  
  appView = new AppView({
    el: $('div.app')
  })

  appView.cards.each (card) ->
    card.memos.fetch()
)