FactoryBot.define do
  factory :availability do
    variant
    store
    size
    quantity { 1 }
  end
end
