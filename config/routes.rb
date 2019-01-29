Rails.application.routes.draw do
  resources :labels
  devise_for :profiles

  resources :transactions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'profiles#show'
end
