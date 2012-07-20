FactoryGirl.define do
  factory :application, class: Doorkeeper::Application do
    name 'Dummy App'
    redirect_uri 'http://dummy.app/callback'
  end
end
