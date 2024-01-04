FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    mobile { Faker::PhoneNumber.phone_number_with_country_code }
    city { Faker::Address.city }
    country { Faker::Address.country }
    profile_title { User::PROFILE_TITLE.sample }
    password { 'password' }
    bio do
      "It is a long established fact that a reader will be distracted
       by the readable content of a page when looking at its layout.
       The point of using Lorem Ipsum is that it has a more-or-less
       normal distribution of letters, as opposed to using 'Content here,
       content here', making it look like readable English."
    end
    confirmed_at { DateTime.now }
  end
end
