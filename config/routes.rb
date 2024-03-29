Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :places do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:show, :index, :destroy]  do
    get "/accept", to: "bookings#accept"
    get "/decline", to: "bookings#decline"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/dashboard", to: "pages#dashboard"
end
