Rails.application.routes.draw do
  devise_for :users
  root 'services#index'

  resources :services, only: [:show]
  resources :favorites, only: [:create, :destroy]

end
