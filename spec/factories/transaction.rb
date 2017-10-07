FactoryGirl.define do
  factory :transaction do
    active true
    sequence(:name) { |n| "some cool name#{n}" } # using faker here would be more neat

    trait :with_bank_guarantee do
      bank_guarantee
    end
  end
end
