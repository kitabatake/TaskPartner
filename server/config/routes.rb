Rails.application.routes.draw do

  resources :card_groups 

  resources :cards do
    resources :memos
    resources :todos
  end

end
