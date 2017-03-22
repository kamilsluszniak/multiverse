Rails.application.routes.draw do

  root 'static_pages#welcome'

  get 'static_pages/index', to: 'static_pages#index'


  resources :planets do
    member do
      get 'resources', to: 'planets#resources'
      get :metal, to: 'planets#show_metal'
      post :metal, to: 'planets#build_metal'
      get :crystal, to: 'planets#show_crystal'
      post :crystal, to: 'planets#build_crystal'
      get :hydrogen, to: 'planets#show_hydrogen'
      post :hydrogen, to: 'planets#build_hydrogen'
      get :solar, to: 'planets#show_solar'
      post :solar, to: 'planets#build_solar'
    end
  end

  get 'static_pages/welcome', to: 'static_pages#welcome'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
