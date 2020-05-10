FactoryBot.define do
  factory :user do
    factory :guest_user do
      email { User.guest_email }
    end

    factory :common_user do
      email { Faker::Internet.email }
      password { '123' }
      name { Faker::Name.first_name }
      sname { Faker::Name.last_name }
      phone { Faker::PhoneNumber.cell_phone_with_country_code }
      state { :common }
    end
  end
end
