Socialguidebook::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    get '/users/sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
    get '/auth/:provider' => 'users/omniauth_callbacks#passthru'
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end
  
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure'                  => 'authentications#failure'
  # match '/auth/:service'               => 'auth#new', :as => :signin
  resources :people
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
  # OmniAuth
  # ユーザーの外部認証処理が成功した場合
  
  match '/login' => 'sessions#login'
  match '/logout' => 'sessions#destroy', :as => :signout
  
  resources :pages do
    resources :posts
  end
  resources :posts do
    resources :comments
    resources :favorites do
      collection do
        get 'add'
      end
    end
  end
  resources :favorites
  resources :thumbnails
  namespace :my do
    root :to => "dashboard#index"
    resources :posts
    resources :pages do
      resources :posts do
        member do
          post 'upload'
        end
      end
    end
    resources :groups do
      collection do
        get 'search'
      end
    end
  end
  
  root :to => "welcome#index"
  
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
