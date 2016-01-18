Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => 'registrations' }

  namespace :admin do
    resources :event_categories
    resources :events
    resources :messages, only: [:index]
    resources :surveys
    resources :users
    resources :wall_messages, only: [:index, :update]
    root :to => "home#index"
  end

  resources :users do
    resources :messages
    resources :albums do
      resources :photos
    end
  end

  resources :avatars
  resources :comments, only: [:new, :create, :update, :destroy]
  resources :events
  resources :groups
  resources :notification_reads, only: [:create]
  resources :passwords
  resources :survey_answers, only: [:create]
  resources :wall_messages, only: [:index, :new, :create]

  get 'notifications/list', to: 'notifications#list', as: 'notifications_list'
  get 'notifications/not_read', to: 'notifications#not_read', as: 'notifications_not_read'

  root :to => "dashboard#index"

end

