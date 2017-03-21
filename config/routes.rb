Rails.application.routes.draw do

  root 'static_pages#welcome'

  get 'static_pages/index', to: 'static_pages#index'
  get 'planets_resources', to: 'planets#resources'

  resources :planets do
    member do
      get :metal
      get :crystal
      get :hydrogen
      get :solar
    end
  end

  get 'static_pages/welcome', to: 'static_pages#welcome'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
