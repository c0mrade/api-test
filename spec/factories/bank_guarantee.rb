FactoryGirl.define do
  factory :bank_guarantee do
    active true
    association :current_transaction, factory: :transaction
  end
end
