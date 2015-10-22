Rails.application.routes.draw do
  root 'stats#index'

  resources :email_events, only: :create
end
