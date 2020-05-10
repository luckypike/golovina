FactoryBot.define do
  factory :order do
    trait :guest_user do
      user factory: :guest_user
    end

    trait :common_user do
      user factory: :common_user
    end

    factory :order_ready do
      user factory: :common_user
    end
  end
end
