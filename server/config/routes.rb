Rails.application.routes.draw do

  resources :cards do
    resources :memos
  end

end
