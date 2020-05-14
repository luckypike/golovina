FactoryBot.define do
  factory :order do
    trait :guest_user do
      user factory: :guest_user
    end

    trait :common_user do
      user factory: :common_user
    end

    factory :pickup_order do
      user factory: :common_user

      to_pay { true }
      delivery { :pickup }
    end
  end
end
