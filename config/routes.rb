Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'users#edit_user'

  scope '/users' do
    get '/edit_user', to: 'users#edit_user', as: 'users_edit_user'
    get '/list_user', to: 'users#list_user', as: 'users_list_user'
    get '/user/:id', to: 'users#show', as: 'user_show'
    resources :clusters
  end

  scope '/timeline', module: 'timeline' do
    resources :linimasa
    get '/show_trash_linimasa/:id', to: 'linimasa#detail_trash', as: 'detail_linimasa_trash'
    get '/show_user/:id', to: 'linimasa#show_user', as: 'detail_user'
    delete '/delete_user/:id', to:'linimasa#delete_user', as: 'delete_user'

    resources :politics
    get '/show_trash_politic/:id', to: 'politics#detail_trash', as: 'detail_politic_trash'
  end

  scope '/pendidikan_politik' do
    get 'edit_pertanyaan', to: 'pendidikan_politik#edit_pertanyaan', as: 'pendidikan_politik_edit_pertanyaan'
    get 'edit_quiz', to: 'pendidikan_politik#edit_quiz', as: 'pendidikan_politik_edit_quiz'
    get 'list_pertanyaan', to: 'pendidikan_politik#list_pertanyaan', as: 'pendidikan_politik_list_pertanyaan'
    get 'list_quiz', to: 'pendidikan_politik#list_quiz', as: 'pendidikan_politik_list_quiz'
  end

  resources :banner, only: [:edit, :update, :show, :index]

  # admins
  get '/admins', to: 'admins#index', as: 'users_list_admin'
  post '/admins/make_admin',to: 'admins#make_admin', as: 'make_admin'
  get '/admins/delete_admin/:id',to: 'admins#delete_admin', as: 'delete_admin'

  # user verifications
  get '/list_user_verification', to: 'user_verifications#verification_list', as: 'users_list_verification'
  get '/user_verification/:id', to: 'user_verifications#show_user_verification', as: 'show_user_verification'
  get '/approve_verification', to: 'user_verifications#approve', as: 'users_approve_verification'
  post '/approve_verification', to: 'user_verifications#approve_verification', as: 'approve_verification'
  get '/reject_verification/:id', to: 'user_verifications#reject_verification', as: 'reject_verification'
end
