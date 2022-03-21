# frozen_string_literal: true

FactoryBot.define do
  factory :variant, class: "Api::Variant" do
    product
    color
    category
    title_ru { Faker::Commerce.product_name }
    state { :active }
    # price { 5000 }

    # trait :with_availability do
    #   transient do
    #     quantity { 1 }
    #   end
    #
    #   after(:create) do |variant, evaluator|
    #     create :availability, variant: variant, quantity: evaluator.quantity, store: create(:store, :default)
    #   end
    # end
    #
    # trait :with_availabilities do
    #   transient do
    #     quantities { [1, 1] }
    #   end
    #
    #   after(:create) do |variant, evaluator|
    #     size = create(:size)
    #     create :availability, variant: variant, size: size, quantity: evaluator.quantities.first, store: create(:store, :default)
    #     create :availability, variant: variant, size: size, quantity: evaluator.quantities.last
    #   end
    # end

    # factory :variant_in_stores do
    #   transient do
    #     stores_count { 2 }
    #   end
    #
    #   after(:create) do |variant, evaluator|
    #     # create_list(:availability, evaluator.stores_count, variant: variant, size: evaluator.size)
    #     create :line_item, invoice: invoice, amount: evaluator.amount
    #   end
    # end
  end
end
