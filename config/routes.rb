RightnowAuc::Application.routes.draw do
  mount Doorkeeper::Engine => "/oauth"

  devise_for :users

  namespace :api do
    namespace :v1 do
      get '/me' => "credentials#me"
    end
  end

  root to: 'home#show'
end
