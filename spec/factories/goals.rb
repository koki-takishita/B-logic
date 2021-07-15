FactoryBot.define do
  factory :goal do
    embodiment { 'weight' } 
    quantification { 50 }
    unit { 'kg' }
    what_to_do { 'lose' }
    deadline_on { Date.tomorrow.next_month }

    trait :goal_run do
      status { :run }
    end

    trait :goal_done do
      status { :done }
    end

    trait :goal_expired do
      status { :expired }
    end

    trait :next_month do
      deadline_on { Date.tomorrow.next_month }
    end

    trait :with_subgoals do
      after(:build) do |goal|
        goal.subgoals << build(:subgoal)
      end
    end
  end
end
