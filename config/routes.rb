Rails.application.routes.draw do

  root 'static_pages#welcome'

  get 'static_pages/index', to: 'static_pages#index'

  get 'static_pages/welcome', to: 'static_pages#welcome'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
