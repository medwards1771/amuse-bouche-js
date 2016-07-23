Rails.application.routes.draw do
  resources :searches, only: [:new, :create]
  root 'searches#new'
end
