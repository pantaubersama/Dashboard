Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'timeline#edit_inimasa'

  scope '/users' do
    get '/edit_user', to: 'users#edit_user', as: 'users_edit_user'
    get '/list_admin', to: 'users#list_admin', as: 'users_list_admin'
    get '/list_user', to: 'users#list_user', as: 'users_list_user'
    get '/list_cluster', to: 'users#list_cluster', as: 'users_list_cluster'
  end

  scope '/timeline' do
    # Janji Politik
    get '/edit_janji_politik', to: 'timeline#edit_janji_politik', as: 'timeline_edit_janji_politik'
    get '/list_janji_politik', to: 'timeline#list_janji_politik', as: 'timeline_list_janji_politik'
    # Linimasa
    get '/edit_inimasa', to: 'timeline#edit_inimasa', as: 'timeline_edit_inimasa'
    get '/show_linimasa/:id', to: 'timeline#show_linimasa', as: 'timeline_show_inimasa'
    get '/list_username', to: 'timeline#list_username', as: 'timeline_list_username'
    post '/new_username', to: 'timeline#new_username', as: 'timeline_new_username'
  end

  scope '/pendidikan_politik' do
    get 'edit_pertanyaan', to: 'pendidikan_politik#edit_pertanyaan', as: 'pendidikan_politik_edit_pertanyaan'
    get 'edit_quiz', to: 'pendidikan_politik#edit_quiz', as: 'pendidikan_politik_edit_quiz'
    get 'list_pertanyaan', to: 'pendidikan_politik#list_pertanyaan', as: 'pendidikan_politik_list_pertanyaan'
    get 'list_quiz', to: 'pendidikan_politik#list_quiz', as: 'pendidikan_politik_list_quiz'
  end
end
