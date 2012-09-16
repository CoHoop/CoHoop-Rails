CohoopRails::Application.routes.draw do
  authenticated :user do
    # Feeds
    root :to => "feeds#filter", via: :post, as: :feed_filtered
    root :to => "feeds#show"
    match '/:feed_type' => 'feeds#filter', via: :post, constraints: { feed_type: /community|tags/ }, as: :feed_filtered_by_type
    match '/:feed_type' => 'feeds#show', constraints: { feed_type: /community|tags/ }, as: :feed
  end

  root to: 'pages#home'

  # Users
  devise_for :users
  resources  :users, :only => [:show, :update] do
    resources :microhoops, only: [:create]
  end

  # Profile
  profile_constraints = { id: /\d+/, first: /[a-zA-Z]+/, last: /[a-zA-Z]+/ }
  match '/:id/:first-:last/' => 'users#show', constraints: profile_constraints , as: :profile

  # User documents
  match '/:id/:first-:last/documents' => 'users_documents#show', constraints: profile_constraints , as: :user_documents
  match '/:id/:first-:last/documents/new' => 'users_documents#new', constraints: profile_constraints , as: :new_user_documents
  match '/:id/:first-:last/documents/create' => 'users_documents#create', constraints: profile_constraints , as: :create_user_documents

  # Documents
  match '/hoop/:id' => 'documents#show', as: :documents

  # Relationships
  resources :relationships,            only: [:create, :destroy]
  resources :users_tags_relationships, only: [:create, :destroy]

  # Tags
  resources :tags, only: [:show]

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
