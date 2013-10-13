Ciudadio::Application.routes.draw do    
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :passwords => "users/passwords" }, :only => [:passwords, :omniauth_callbacks]

  resources :languages, :only => [:update]
    
  devise_scope :user do
    
    get "/sign_up", :to => "devise/registrations#new"
    get "/sign_in", :to => "devise/sessions#new", :as => "new_user_session"
    
    namespace :users do
      
      post '/auth/create', :to => "omniauth_callbacks#create", :as => :auth_sign_up
      delete '/auth/cancel', :to => "omniauth_callbacks#cancel", :as => :cancel_auth_sign_up
      delete '/auth/:id', :to => 'omniauth_callbacks#destroy', :as => :auth
    end
    
    post "/account/create", :to => "devise/registrations#create"
    delete "/account/deactivate", :to => "devise/registrations#destroy"
    get "/account/recover_password", :to => "devise/passwords#new"
    get "/account/reset_password", :to => "devise/passwords#edit", :as => "edit_user_password"

    post "/log_in", :to => "devise/sessions#create", :as => "user_session"
    delete "/log_out", :to => "devise/sessions#destroy", :as => "destroy_user_session"
    
  end
  
  namespace :api do
    devise_for :users
    get '/profiles/:profile', :to => 'users#profile'
    
    resources :tips, :only => [:create, :update, :index]
    post '/tips/:id', :to => 'tips#destroy'
    
    resources :parkings, :only => [:create, :update, :index]
    post '/parkings/:id', :to => 'parkings#destroy'
    
    resources :workshops, :only => [:create, :update, :index]
    post '/workshops/:id', :to => 'workshops#destroy'
    
    resources :cycling_groups, :only => [:index]    
    resources :trips, :only => [:index]

    resources :routes, :only => [:create, :update, :index, :show]
    post '/routes/:id', :to => 'routes#destroy'

  end
  
  namespace :settings do
    get "profile"
    get "access"
    put "changed"
    put "change_picture"
    delete "destroy_picture"
  end

  get '/profiles/:username' => 'profiles#index', :as => "user_profile"
  get '/profiles/:username/activity' => 'profiles#activity', :as => "user_profile_activity"
  #get '/profiles/:username/gear' => 'profiles#gear', :as => 'user_gear'
=begin  

  namespace :profiles do
    resources :incidents do
      put 'solved', :to => 'incidents#update_status', :defaults => { :solved => true }
      put 'unsolved', :to => 'incidents#update_status', :defaults => { :solved => false }
    end

    resources :tips
    resources :places
    resources :workshops
    resources :parkings
  end
  
  namespace :maps do 
    resources :incidents, :only => [:index]
    resources :tips, :only => [:index]
    resources :lanes, :only => [:index]
    resources :routes, :only => [:index]
    resources :places, :only => [:index]
  end
  
  resources :maps, :only => [:index]

  resources :promoteds do
    resources :pictures, :only => [:create]
  end
  
  post    '/promoteds/:id/like' => 'promoteds/likes#create'
  delete  '/promoteds/:id/like' => 'promoteds/likes#destroy'
  
  resources :bikes do
    collection do 
      get :stolen
      get :recovered
      get :popular
      get :sell_or_rent
      get :shared
      get :services_and_accessories
    end
    
    resources :pictures, :only => [:create]
    resources :bike_statuses, :controller => 'bikes/statuses', :only => [:create, :update]
  end
  
  post    '/bikes/:id/like' => 'bikes/likes#create'
  delete  '/bikes/:id/like' => 'bikes/likes#destroy'
=end
 
  resources :pictures, :only => [:destroy] do
    member do
      put :set_main
      put :change_caption
    end
  end
    
  get '/welcome' => 'welcome#index'
  get '/about' => 'welcome#about'
  
  #resources :comments, :only => [:create, :destroy]
  
  get '/rodadas' => redirect('/discover/cycling_groups')
  get '/rodada/nueva' => redirect('/discover/cycling_groups/new')
  
  get '/discover/trips' => 'trips#index'
  get '/discover/trips/:id' => 'trips#show'
  get '/discover/cycling_groups' => 'cycling_groups#index'
  get '/discover/cycling_groups/new' => 'cycling_groups#new'
  post '/discover/cycling_groups' => 'cycling_groups#create'
  get '/discover/cycling_groups/:id/edit' => 'cycling_groups#edit', :as => 'discover_cycling_groups_edit'
  put '/discover/cycling_groups/:id' => 'cycling_groups#update', :as => 'discover_cycling_group'
  get '/discover/cycling_groups/:id' => 'cycling_groups#destroy', :as => 'discover_cycling_group_destroy'
  
  #  get "/places/:id" => 'places#show', :as => "place"
  #  get "/places/edit/:id" => 'places#edit', :as => "edit_place"  
  
  root :to => 'welcome#index'
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

end
