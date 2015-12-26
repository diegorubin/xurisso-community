Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :events
    resources :messages, :only => [:index]
    resources :surveys
    resources :users
    resources :wall_messages, :only => [:index, :update]
    root :to => "home#index"
  end

  resources :users do
    resources :messages
    resources :albums do
      resources :photos
    end
  end

  resources :avatars
  resources :comments, :only => [:new, :create, :update, :destroy]
  resources :events
  resources :passwords
  resources :survey_answers, :only => [:create]
  resources :wall_messages, :only => [:index, :new, :create]

  get "/presentation" => "presentation#index", :as => 'presentation'
  root :to => "dashboard#index"

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end

