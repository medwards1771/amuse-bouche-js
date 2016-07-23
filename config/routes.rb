Rails.application.routes.draw do
  resources :searches, only: [:new, :index, :create]
  root 'searches#new'
end
