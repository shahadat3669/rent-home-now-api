Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: {format: 'json'} do
      resources :properties, only: %i[index show create update destroy]
      resources :reservation_criterias, only: [:index, :show, :create, :update, :destroy]
      resources :categories, only: [:index]
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
