Rails.application.routes.draw do

  # get 'users/:id/favs/create' => 'favs#create', :as => 'create_fav'
  get 'users/:id/favs/new' => 'favs#new', :as=> 'new_fav'
  get 'users/:id/favs/:fav_id' => 'favs#show', :as => 'fav'
  delete 'users/:id/favs/:fav_id' => 'favs#destroy', :as => 'delete_fav'
  get 'users/:id/favs/:fav_id/edit' => 'favs#edit', :as => 'edit_fav'
  get 'users/:id/favs/index' => 'favs#index', :as => 'favs'
  post 'users/:id/favs/index' => 'favs#create'
  patch 'users/:id/favs/:fav_id' => 'favs#update', :as => 'update_fav'
  get 'favs/destroy'

    get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root :to => 'pages#index'

  resources :teams, :only => [:show]

  resources :users

  resources :clubs, :only => [:index, :show]

  resources :grounds, :only => [:show, :index, :new, :create]

  resources :matches


  get '/dashboard' => 'pages#dashboard' , :as=> 'dashboard'#user-specific dash


  #login is not crud
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  get '/:age_group/:division/:id', :to => redirect('/teams/:id')
  get '/:age_group/:division' => 'pages#division', :as=> 'division'
  get '/:age_group' => 'pages#age_group', :as=> 'age_group'


end
