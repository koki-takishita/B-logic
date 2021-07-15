FactoryBot.define do
  factory :subgoal do
    embodiment { '体脂肪率' } 
    quantification { 10 }
    unit { '%' }
    subgoal { '体脂肪をさげる' }
    deadline_on { Date.tomorrow }

    trait :next_month do
      deadline_on { Date.tomorrow.next_month }
    end

    trait :subgoal_run do
      status { :run }
    end

    trait :subgoal_done do
      status { :done }
    end

    trait :subgoal_expired do
      status { :expired }
    end

  end
end
