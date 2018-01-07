Rails.application.routes.draw do
  root 'services#index'

  resources :services, only: [:show]

end
