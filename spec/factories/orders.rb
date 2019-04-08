FactoryBot.define do
  factory :order do
    user
    address { 'address' }
  end
end
