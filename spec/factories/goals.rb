FactoryBot.define do
  factory :goal do
    embodiment { 'weight' } 
    quantification { 50 }
    unit { 'kg' }
    what_to_do { 'lose' }
    deadline_on { Date.tomorrow }

    trait :active do
      status { :active }
    end

    trait :inactive do
      status { :inactive }
    end

    trait :association do
      association :user
    end
  end
end
