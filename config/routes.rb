ActionController::Routing::Routes.draw do |map|
  map.resources :cables

  map.resources :test_pmds

  map.resources :test_orls

  map.resources :test_chromatic_disps

  map.resources :test_attenuations

  map.resources :jumpers

  map.resources :log_books

  map.resources :sites_additional_informations

  map.resources :users_logs

  map.resources :fibers

  map.resources :subrack_names

  map.resources :diagrams

  map.resources :spans

  map.resources :addresses

  map.resources :users_projects

  map.resources :companies, :has_many => :spans

  map.resources :projects

  map.resources :sites

  map.resources :network_owners, :has_many => :sites

  map.resources :users

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.


  map.index 'optibuilder', :controller => 'home'
  map.index 'optibuilder/home', :controller => 'home', :action => 'index'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
