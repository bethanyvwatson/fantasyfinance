Rails.application.routes.draw do
  devise_for :profiles
  resources :profiles, only: [:show]
  resources :transactions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'application#show'
end
