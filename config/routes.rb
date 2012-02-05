Ciudadio::Application.routes.draw do
  devise_for :admins

  devise_for :users, :only => [:passwords] do
    get "/sign_up", :to => "devise/registrations#new"
    get "/sign_in", :to => "devise/sessions#new", :as => "new_user_session"
    delete "/sign_out", :to => "devise/sessions#destroy", :as => "destroy_user_session"
    
    post "/account/create", :to => "devise/registrations#create"
    delete "/account/deactivate", :to => "devise/registrations#destroy"
    get "/account/recover_password", :to => "devise/passwords#new"
    get "/account/reset_password", :to => "devise/passwords#edit", :as => "edit_user_password"

    post "/log_in", :to => "devise/sessions#create", :as => "user_session"
  end
  
  namespace :settings do
    match "account", :via => :get
    match "access", :via => :get
    match "profile", :via => :get
    match "changed", :via => :put
  end
  
  namespace :places do
    match 'search' => 'searches#main', :via => :get
    match 'search' => 'searches#execute_main', :via => :post
    match '/' => 'listings#index', :via => :get
    match "/" => "commits#create", :via => :post
    match ":id" => "commits#update", :via => :put
    match ":place_id/announcements" => 'commits#announce', :via => :post
    match ":id/followers" => 'representations#followers', :via => :get, :as => "followers"
    match ":id/announcements" => 'representations#announcements', :via => :get, :as => "announcements"
    match ":id/comments" => 'representations#comments', :via => :get, :as => "comments"
    match ":id/comments" => 'commits#comment', :via => :post
  end

  match "places/new" => 'places/commits#new', :via => :get, :as => "new_place"
  match "places/:id" => 'places/representations#show', :via => :get, :as => "place"
  match "places/edit/:id" => 'places/commits#edit', :via => :get, :as => "edit_place"
  
  match "/places/:id/announcements" => 'places/commits#unannounce', :via => :delete, :as => "delete_place_announcement"
  match "places/:id/follow/on" => 'places/commits#follow', :via => :put, :as => "place_follow_on", :defaults => { :follow => "on" }
  match "places/:id/follow/off" => 'places/commits#follow', :via => :put, :as => "place_follow_off", :defaults => { :follow => "off" }
  
  match "/places/:id/comments" => 'places/commits#uncomment', :via => :delete, :as => "delete_place_comment"
  
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
