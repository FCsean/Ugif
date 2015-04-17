Rails.application.routes.draw do
  
  get 'signup' => 'users#signup'
  resources :users
  
  get 'signin' => 'sessions#signin'
  resources :sessions
  get 'signout' => 'sessions#destroy'
  
  get 'upload' => 'gifs#upload'
  resources :gifs
  
  get 'home' => 'gifs#home'
  root 'gifs#home'
  
  get 'view/:id' => 'gifs#view'
  post 'like/:id' => 'gifs#like'
  post 'dislike/:id' => 'gifs#dislike'
  
  
  get 'account/:username'  => 'accounts#account'
  
  get 'search' => 'gifs#search'
  
  post 'comment' => 'gifs#comment'

  delete 'delete/:id' => 'gifs#delete'

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
