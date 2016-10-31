Rails.application.routes.draw do
  root 'chats#index'
  resources :chats
  resources :users, only: [:index]
  mount ActionCable.server => '/cable'
end
