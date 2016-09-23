Rails.application.routes.draw do


root 'static_pages#home'

  #devise_for :users


  devise_for :users,controllers: { sessions: 'users/sessions' ,passwords: 'users/passwords',
                                    registrations:'users/registrations',confirmations:'users/confirmations'}

    get 'profile/student_dashboard' => 'profiles#student_dashboard', as: :student_dashboard
    get 'profile/employer_dashboard' => 'profiles#employer_dashboard', as: :employer_dashboard

    get 'profile/:id' => 'profiles#show' , as: :profile


  resources :tests do
    # member do
    #   get :add_questions
    #   post :push_questions
    # end

    resources :questions
  end
  get 'add_question_to_current_test/:test_id/:question_id' , to: 'tests#add_question_to_current_test' ,as: :add_question_to_current_test
  #resources :questions
  get 'remove_question_from_current_test/:test_id/:question_id' , to: 'tests#remove_question_from_current_test' ,as: :remove_question_from_current_test


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
