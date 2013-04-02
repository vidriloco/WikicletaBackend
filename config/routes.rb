Ciudadio::Application.routes.draw do  
  devise_for :admins, :only => [:sessions]
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :passwords => "users/passwords" }, :only => [:passwords, :omniauth_callbacks]

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
  
  namespace :settings do
    get "profile", :via => :get
    get "access", :via => :get
    put "changed", :via => :put
  end
  
  namespace :profiles do
    resources :incidents, :only => [:index]
    resources :tips
  end
  
  namespace :maps do 
    resources :incidents
    resources :tips, :only => [:index]
    resources :lanes, :only => [:index]
    resources :routes, :only => [:index]
  end
  
  resources :neighbourhoods
  
  resources :maps, :only => [:index]

  resources :bikes do
    collection do 
      get :search
      get :popular
    end
    
    resources :pictures, :only => [:create]
    resources :bike_statuses, :controller => 'bikes/statuses', :only => [:create, :update]
  end
    
  resources :pictures, :only => [:destroy] do
    member do
      put :set_main
      put :change_caption
    end
  end
  
  post    '/bikes/:id/like' => 'bikes/likes#create'
  delete  '/bikes/:id/like' => 'bikes/likes#destroy'
  
  get '/welcome' => 'welcome#index'
  get '/about' => 'welcome#about'
  
  resources :comments, :only => [:create, :destroy]
  
  get '/profile/:username' => 'profiles#index', :as => "user_profile"
  get '/profile/:username/bikes' => 'profiles#bikes', :as => 'user_bikes'
#  get "/places/:id" => 'places#show', :as => "place"
#  get "/places/edit/:id" => 'places#edit', :as => "edit_place"  
  
  root :to => 'welcome#index'
end
