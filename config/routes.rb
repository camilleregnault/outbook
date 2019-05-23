Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :places
  resources :bookings, only: [:new, :create, :show, :index, :delete]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
