Rails.application.routes.draw do
  root 'projects#welcom'
  resources :projects do
   post "/like", to: "likes#like_toggle"
  end

  get '/like/warning/:project_id' => 'like#warning'

  get '/option/:id' => 'projects#option'
  
  # get 'projects/index' => 'projects#index'
  get '/profile' =>'projects#profile'
  get '/teambuilding/:id' => 'projects#teambuilding' #id는 project의 id
  get '/teambuilding2/:id' => 'projects#teambuilding2'
  # get '/projects/new' => 'projects#new'
  # post '/projects' => 'projects#create'
  get '/projects/:id' => 'projects#show'
  # delete '/projects/:id' => 'projects#destroy'
  post '/projects/:id/completebuilding' => 'projects#completebuilding'
  # get '/projects/:id/completebuilding' => 'projects#completebuilding'
  post '/projects/:id/ending' => 'projects#ending'
  
  get '/evaluation/:project_id'=> 'projects#evaluation' #만족도 평가 페이지
  post '/evaluate/:project_id'=> 'projects#evaluate'
  get '/check' => 'projects#check'
  
  # 여기 수정좀
  get '/profile' => 'project#profile'
  
  devise_for :users
  
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
