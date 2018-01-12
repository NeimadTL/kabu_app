Rails.application.routes.draw do
  devise_for :users
  root 'services#index'

  resources :services, only: [:show] do
    resources :comments, only: [:create]
  end

  resources :favorites, only: [:index, :create, :destroy]

  namespace :business do
    resources :services, only: [:new, :create, :edit, :update, :destroy]
  end

end
