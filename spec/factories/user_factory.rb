FactoryGirl.define do
  factory :user do
    email 'user@example.org'
    password '123456'
    password_confirmation { password }

    factory :user_of do
      ignore do
        application nil
        app_admin false
      end

      after(:create) do |user, evaluator|
        user.accessions.create(application: evaluator.application,
                               admin: evaluator.app_admin)
      end

      factory :admin_of do
        ignore do
          app_admin true
        end
      end
    end
  end
end
