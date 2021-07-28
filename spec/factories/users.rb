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

    trait :with_goals do
      after(:build) do |user|
        user.goals << build(:goal)
      end
    end

    trait :with_goals_next_month do
      after(:build) do |user|
        user.goals << build(:goal, :next_month)
      end
    end

    trait :with_goal_and_subgoal do
      after(:build) do |user|
        user.goals << build(:goal, :with_subgoals)
      end
    end
  end
end
