FactoryBot.define do
  factory :user do
    sequence(:email){|n| "test#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }

    trait :not_match_password do
      password { 'foobar' }
      password_confirmation { 'barbraz' }
    end

    trait :shortage_password do
      password { 'foo' }
      password_confirmation { 'foo' }
    end
  end
end
