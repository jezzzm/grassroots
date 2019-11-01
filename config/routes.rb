Rails.application.routes.draw do

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root :to => 'pages#index'

  resources :teams, :only => [:show]

  resources :users, :only => [:new, :create]

  resources :clubs, :only => [:index, :show]

  resources :grounds, :only => [:show, :index]

  resources :matches

  get '/:age_group/:division/:team' => 'teams#show'
  get '/:age_group/:division' => 'pages#division'


  #login is not crud
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  get '/:age_group' => 'pages#age_group'
end
