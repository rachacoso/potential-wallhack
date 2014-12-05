Rails.application.routes.draw do

  root 'home#front'

  get   '/login' => 'session#new', as: 'login'
  post  '/login' => 'session#create'
  get   '/logout' => 'session#destroy', as: 'logout'

  get   '/dashboard' => 'home#dashboard', as: 'dashboard'

  get   '/admin' => 'admin#index', as: 'admin'

  resources :sectors, only: [:create, :update, :destroy]
  resources :channels, only: [:create, :update, :destroy]
  resources :company_sizes, only: [:create, :update, :destroy]
  resources :countries, only: [:create, :update, :destroy]
  resources :channel_capacities, only: [:create, :update, :destroy]

  post '/bulkupdate' => 'channel_capacities#bulkupdate', as: 'channel_capacity_bulkupdate'

  resources :displays, only: [:create, :update, :destroy]
  resources :distributor_brands, only: [:create, :update, :destroy]
  resources :trade_shows, only: [:create, :update, :destroy]
  resources :press_hits, only: [:create, :update, :destroy]
  delete '/press_hits/file_delete/:id' => 'press_hits#file_destroy', as: 'press_hits_file_delete'
  resources :products, only: [:create, :update, :destroy]
  resources :patents, only: [:create, :update, :destroy]
  resources :trademarks, only: [:create, :update, :destroy]
  resources :compliances, only: [:create, :update, :destroy]
  resources :export_countries, only: [:create, :update, :destroy]


  resources :product_photos, only: [:create]
  delete '/product_photos/:id' => 'product_photos#destroy', as: 'product_photo_delete'

  resources :library_documents, only: [:create, :index]
  delete '/library_documents/:id' => 'library_documents#destroy', as: 'library_document_delete'


  # Deprecated
  # resources :sales_sizes, only: [:create, :update, :destroy]
  # resources :marketing_spends, only: [:create, :update, :destroy]
  

  resources :users, only: [:new, :create, :edit, :update, :destroy, :index]
  
  get    '/distributors' => 'distributors#edit', as: 'distributor'
  get    '/distributors/public_profile' => 'distributors#public_profile', as: 'distributor_public_profile'
  get    '/distributors/full_profile' => 'distributors#full_profile', as: 'distributor_full_profile'
  patch  '/distributors' => 'distributors#update'
  patch  '/distributor_brands' => 'distributor_brands#update'
  
  get    '/brands' => 'brands#edit', as: 'brand'
  get    '/brands/public_profile' => 'brands#public_profile', as: 'brand_public_profile'
  get    '/brands/full_profile' => 'brands#full_profile', as: 'brand_full_profile'
  patch  '/brands' => 'brands#update'

  get '/onboard/distributor/one' => 'onboard_distributor#one', as: 'onboard_distributor_one'
  get '/onboard/distributor/two' => 'onboard_distributor#two', as: 'onboard_distributor_two'
  get '/onboard/distributor/three' => 'onboard_distributor#three', as: 'onboard_distributor_three'
  get '/onboard/distributor/four' => 'onboard_distributor#four', as: 'onboard_distributor_four'
  get '/onboard/distributor/five' => 'onboard_distributor#five', as: 'onboard_distributor_five'
  get '/onboard/distributor/six' => 'onboard_distributor#six', as: 'onboard_distributor_six'
  # get '/onboard/distributor/seven' => 'onboard_distributor#seven', as: 'onboard_distributor_seven'
  # get '/onboard/distributor/eight' => 'onboard_distributor#eight', as: 'onboard_distributor_eight'

  get '/onboard/brand/one' => 'onboard_brand#one', as: 'onboard_brand_one'
  get '/onboard/brand/two' => 'onboard_brand#two', as: 'onboard_brand_two'
  get '/onboard/brand/three' => 'onboard_brand#three', as: 'onboard_brand_three'
  get '/onboard/brand/four' => 'onboard_brand#four', as: 'onboard_brand_four'
  get '/onboard/brand/five' => 'onboard_brand#five', as: 'onboard_brand_five'
  get '/onboard/brand/six' => 'onboard_brand#six', as: 'onboard_brand_six'
  get '/onboard/brand/seven' => 'onboard_brand#seven', as: 'onboard_brand_seven'
  get '/onboard/brand/eight' => 'onboard_brand#eight', as: 'onboard_brand_eight'

  get '/matches' => 'matches#index', as: 'all_matches'
  get '/savedmatches' => 'matches#index_saved_matches', as: 'saved_matches'
  post '/matches' => 'matches#index'
  get '/matches/save/:match_id' => 'matches#save_match', as: 'save_match'
  get '/matches/unsave/:match_id' => 'matches#unsave_match', as: 'unsave_match'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
