Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'pages#home'

  get '/about', to: 'pages#about', as: 'pages_about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
