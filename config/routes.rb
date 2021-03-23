Rails.application.routes.draw do
  resources :orders
  resources :items
  resources :clubs
  resources :positions
  devise_for :members
  get '/members/my_dashboard', to: 'members#my_dashboard'
  get '/members/new_member', to: 'members#new_member'
  root to: 'pages#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
