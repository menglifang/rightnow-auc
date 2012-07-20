RightnowAuc::Application.routes.draw do
  mount Doorkeeper::Engine => "/oauth"

  devise_for :users
  namespace :api, defaults: { format: 'json' } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :applications do
        resources :users, only: [:index, :create, :destroy]
      end

      get '/me' => "credentials#me"
    end
  end

  resource :home, only: :show
  resources :users, only: :index do
    resources :accessions, only: [:index, :create, :destroy]
  end
  resources :accessible_applications, only: :index

  root to: 'home#show'
end
