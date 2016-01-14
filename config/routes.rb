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
  resources :notifications, only: [:index]
  resources :passwords
  resources :survey_answers, only: [:create]
  resources :wall_messages, only: [:index, :new, :create]

  root :to => "dashboard#index"

end

