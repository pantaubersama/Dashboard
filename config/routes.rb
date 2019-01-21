Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'users#edit_user'

  scope '/users' do
    get '/edit_user', to: 'users#edit_user', as: 'users_edit_user'
    get '/list_admin', to: 'users#list_admin', as: 'users_list_admin'
    get '/list_user', to: 'users#list_user', as: 'users_list_user'
    get '/list_user_verification', to: 'users#verification_list', as: 'users_list_verification'
    get '/user/:id', to: 'users#show', as: 'user_show'
    get '/approve_verification', to: 'users#approve', as: 'users_approve_verification'
    post '/approve_verification', to: 'users#approve_verification', as: 'approve_verification'
    get '/reject_verification/:id', to: 'users#reject_verification', as: 'reject_verification'
    resources :clusters
    resources :user_clusters
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
  post 'admin/make_admin',to: 'admins#make_admin', as: 'make_admin'
  get 'admin/delete_admin/:id',to: 'admins#delete_admin', as: 'delete_admin'
end
