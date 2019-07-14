Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :game
    end
  end
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'
  end
  resources :members
  # resources :members, only: [:index, :show]
  resources :users
  resources :match_records do
    collection do
      post :confirm, to: 'match_records#confirm'
      get 'autocomplete/:term', to: 'match_records#autocomplete'
    end
  end
  root to: 'members#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
