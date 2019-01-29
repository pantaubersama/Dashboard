Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :dashboards, only: [:index]
  resources :broadcasts, only: [:index, :show]

  root 'dashboards#index'

  scope '/users' do
    get '/edit_user', to: 'users#edit_user', as: 'users_edit_user'
    get '/list_user', to: 'users#list_user', as: 'users_list_user'
    get '/list_user_cluster', to: 'users#list_user_cluster', as: 'users_list_user_cluster'
    get '/detail_user_cluster', to: 'users#detail_user_cluster', as: 'users_detail_user_cluster'
    get '/user/:id', to: 'users#show', as: 'user_show'
    resources :user_clusters, except: :destroy
    delete '/user_clusters/:id/remove_user/:user_id', to:'user_clusters#destroy', as: 'remove_user'
    resources :clusters do
      collection do
        get '/detail_category/:id', to: 'clusters#detail_category', as: 'detail_category'
        put '/update_category/:id', to: 'clusters#update_category', as: 'update_category'
        get '/edit_category/:id', to: 'clusters#edit_category', as: 'edit_category'
        get '/detail_trash/:id', to: 'clusters#detail_trash', as: 'detail_trash'
        get :search_categories
        post :create_category
      end
    end
  end

  scope '/timeline', module: 'timeline' do
    resources :linimasa
    get '/show_trash_linimasa/:id', to: 'linimasa#detail_trash', as: 'detail_linimasa_trash'
    get '/show_user/:id', to: 'linimasa#show_user', as: 'detail_user'
    delete '/delete_user/:id', to:'linimasa#delete_user', as: 'delete_user'

    resources :politics
    get '/show_trash_politic/:id', to: 'politics#detail_trash', as: 'detail_politic_trash'
    get '/search_clusters/', to: 'politics#search_clusters', as: 'search_clusters'
  end

  resources :banner, only: [:edit, :update, :show, :index]
  resources :political_party
  resources :badges do
    collection do
      get 'grant', to: 'badges#grant_badge', as: 'grant_badge'
      post 'grant', to: 'badges#grant_badge_user'
    end
  end
  resources :questions
  resources :quiz
  resources :categories

  # admins
  get '/admins', to: 'admins#index', as: 'users_list_admin'
  post '/admins/make_admin',to: 'admins#make_admin', as: 'make_admin'
  get '/admins/delete_admin/:id',to: 'admins#delete_admin', as: 'delete_admin'

  # users
  get '/user/:id/edit', to: 'users#edit', as: 'user_edit'
  put '/user/:id', to: 'users#update', as: 'user_update'
  put '/user/:id/informant', to: 'users#update_informant', as: 'user_update_informant'
  put '/user/:id/avatar', to: 'users#update_avatar', as: 'user_update_avatar'

  resources :user_verifications, only: [:index, :show, :create] do
    collection do
      get 'approve/:id', to: 'user_verifications#approve', as: 'approve_verification'
      get 'reject/:id', to: 'user_verifications#reject', as: 'reject_verification'
    end
  end

end
