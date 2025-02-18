Rails.application.routes.draw do
  # User authentication routes
  post "signup", to: "users#create"
  post "login", to: "sessions#create"

  # Routes that require authentication
  namespace :api do
    namespace :v1 do
      resources :posts do
        resources :comments, only: [ :create, :update, :destroy ]
      end
    end
  end
end
