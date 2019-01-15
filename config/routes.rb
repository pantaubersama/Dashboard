Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'users#edit_user'

  scope '/users' do
    get '/edit_user', to: 'users#edit_user', as: 'users_edit_user'
    get '/list_admin', to: 'users#list_admin', as: 'users_list_admin'
    get '/list_user', to: 'users#list_user', as: 'users_list_user'
    resources :clusters
  end

  scope '/timeline' do
    # Janji Politik
    get '/edit_janji_politik', to: 'timeline#edit_janji_politik', as: 'timeline_edit_janji_politik'
    get '/list_janji_politik', to: 'timeline#list_janji_politik', as: 'timeline_list_janji_politik'
    
    # Linimasa
    resources :linimasa
  end

  scope '/pendidikan_politik' do
    get 'edit_pertanyaan', to: 'pendidikan_politik#edit_pertanyaan', as: 'pendidikan_politik_edit_pertanyaan'
    get 'edit_quiz', to: 'pendidikan_politik#edit_quiz', as: 'pendidikan_politik_edit_quiz'
    get 'list_pertanyaan', to: 'pendidikan_politik#list_pertanyaan', as: 'pendidikan_politik_list_pertanyaan'
    get 'list_quiz', to: 'pendidikan_politik#list_quiz', as: 'pendidikan_politik_list_quiz'
  end
end
