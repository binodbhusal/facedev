# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ActiveRecord::Base.transaction do
    500.times do |i|
        user = User.create(
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email,
            mobile: Faker::PhoneNumber.phone_number_with_country_code,
            city: Faker::Address.city,
            country: Faker::Address.country,
            profile_title: User::PROFILE_TITLE.sample,
            password: 'password',
            bio: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",

        )
        puts "user #{i+1} created successfully"
    end
end