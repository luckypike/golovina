FactoryBot.define do
  factory :refund do
    state { 1 }
    reason { 1 }
    detail { "MyText" }
  end
end
