Rails.application.routes.draw do

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root :to => 'pages#index'

  resources :teams, :only => [:show]

  resources :users, :only => [:index, :new, :create]

  resources :clubs, :only => [:index, :show]

  resources :grounds, :only => [:show, :index]

  resources :matches




  #login is not crud
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  get '/:age_group/:division/:id', :to => redirect('/teams/:id')
  get '/:age_group/:division' => 'pages#division', :as=> 'division'
  get '/:age_group' => 'pages#age_group', :as=> 'age_group'


end
