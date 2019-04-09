FactoryBot.define do
  factory :order_item do
    order
    variant
    size
    quantity { 1 }
  end
end
