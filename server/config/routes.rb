Rails.application.routes.draw do

  resources :cards do
    resources :memos
    resources :todos
  end

end
