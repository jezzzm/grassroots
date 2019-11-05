Rails.application.routes.draw do
  root :to => 'pages#index'
  resources :teams
  resources :users
  resources :clubs
  resources :grounds
  resources :matches
  get '/dashboard' => 'pages#dashboard', :as=> 'dashboard'
  get '/navigator' => 'pages#navigator', :as => 'navigator'
  #login
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  #custom paths for favourites - they should appear under under user
  get 'users/:id/favs/find' => 'favs#find', :as=> 'find_fav'
  post 'users/:id/favs/new' => 'favs#new', :as=> 'new_fav'
  get 'users/:id/favs/:fav_id' => 'favs#show', :as => 'fav'
  delete 'users/:id/favs/:fav_id' => 'favs#destroy', :as => 'delete_fav'
  get 'users/:id/favs/:fav_id/edit' => 'favs#edit', :as => 'edit_fav'
  get 'users/:id/favs/index' => 'favs#index', :as => 'favs'
  post 'users/:id/favs/index' => 'favs#create'
  patch 'users/:id/favs/:fav_id' => 'favs#update', :as => 'update_fav'

  #paths for age groups and divisions
  get '/:age_group/:division/:id', :to => redirect('/teams/:id')
  get '/:age_group/:division' => 'pages#division', :as=> 'division'
  get '/:age_group' => 'pages#age_group', :as=> 'age_group'


end
