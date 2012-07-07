RightnowAuc::Application.routes.draw do
  mount Doorkeeper::Engine => "/oauth"

  devise_for :users

  namespace :api do
    namespace :v1 do
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
