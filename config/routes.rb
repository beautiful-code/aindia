# frozen_string_literal: true

Rails.application.routes.draw do
  # root 'users#new'
  root 'static_pages#home'
  get 'static_pages/home'
  get 'sessions/create'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:show, :new, :create] do
    member do
      get 'interests'
      post 'update_support_issue'
      post 'update_follow_interests'
    end
  end

  resources :issues, only: %i[new create destroy edit update]
end
