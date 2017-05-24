Rails.application.routes.draw do
  root 'users#new'
  get 'users/new'
  get 'sessions/create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :issues,          only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/auth/:provider/callback', :to => 'sessions#create', via: :get

end
