Rails.application.routes.draw do
  resources :orders
  resources :items
  resources :clubs
  resources :positions
  resources :members
  devise_for :members
  get '/members/my_dashboard', to: 'members#my_dashboard'
  get '/members/new_member', to: 'members#new_member'
  get '/about', to: 'pages#about'
  get '/items/:id/orders', to: 'items#item_history'
  root to: 'members#my_dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
