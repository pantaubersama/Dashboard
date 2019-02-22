Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :dashboards, only: [:index] do
    collection do
      get :data_question
      get :data_registration
    end
  end
  resources :broadcasts

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
        get 'trash'
        get :search_categories
        post :create_category
      end
      member do
        get :detail_trash
        post :approve_cluster
        post :reject_cluster
      end
    end
  end

  scope '/timeline', module: 'timeline' do
    resources :linimasa do
      collection do
        get :trash
        get :list_username
      end
    end
    get '/show_trash_linimasa/:id', to: 'linimasa#detail_trash', as: 'detail_linimasa_trash'
    get '/show_user/:id', to: 'linimasa#show_user', as: 'detail_user'
    delete '/delete_user/:id', to:'linimasa#delete_user', as: 'delete_user'

    resources :politics do
      collection do
        get :trash
      end
    end
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
  resources :folders
  resources :questions do
    collection do
      get 'trash'
    end
    member do
      get 'detail_trash'
      get 'upvote'
      post 'action_upvote'
    end
  end
  resources :quiz do
    collection do
      get 'trash'
      get 'download_as_json'
      get 'download_as_csv'
    end
    member do
      post 'publish'
      post 'draft'
      get 'download_as_json'
      get 'download_as_csv'
    end
  end
  resources :categories

  # admins
  get '/admins', to: 'admins#index', as: 'users_list_admin'
  post '/admins/make_admin',to: 'admins#make_admin', as: 'make_admin'
  get '/admins/delete_admin/:id',to: 'admins#delete_admin', as: 'delete_admin'
  get '/admins/search_users_for_admin', to: 'admins#search_users', as: 'search_users_for_admin'

  # users
  get '/user/:id/edit', to: 'users#edit', as: 'user_edit'
  put '/user/:id', to: 'users#update', as: 'user_update'
  put '/user/:id/informant', to: 'users#update_informant', as: 'user_update_informant'
  put '/user/:id/avatar', to: 'users#update_avatar', as: 'user_update_avatar'

  resources :user_verifications, only: [:index, :show, :create] do
    collection do
      get 'reset/:id', to: 'user_verifications#reset', as: 'reset'
      post 'reset/:id', to: 'user_verifications#reset_action', as: 'reset_action'
      get 'accepted', to: 'user_verifications#accepted', as: 'accepted'
      get 'rejected', to: 'user_verifications#rejected', as: 'rejected'
      get 'approve/:id', to: 'user_verifications#approve', as: 'approve_verification'
      get 'reject/:id', to: 'user_verifications#reject', as: 'reject_verification'
    end
  end

end
