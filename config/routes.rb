Rails.application.routes.draw do
  # root 'users#new'
  root 'static_pages#home'

  get 'users/new'
  get 'sessions/create'
  delete '/logout',  to: 'sessions#destroy'
  put 'select_interests', to: 'users#selectinterests', as: :select_interests
  post 'users/:id/followinterest/:interest_id', to: 'users#update_follow_interests', as: :follow_interest

  get 'static_pages/home'
  post 'static_pages/update_support_issue'
  post 'users/update_support_issue'

  resources :users do
    member do
      get 'interests'
    end
  end

  resources :issues,          only: [:new, :create, :destroy, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/auth/:provider/callback', :to => 'sessions#create', via: :get
  # match '/auth/:provider/callback' => 'sessions#callback', via: :get

end
