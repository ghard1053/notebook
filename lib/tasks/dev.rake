namespace :dev do
  desc "Configura"
  task setup: :environment do
    100.time do |i|
      Contact.create!(
        name: Faker::Name.name,
        emai: Faker::Internet.email,
        birthdate: Faker::Date.between(65.years.ago, 18.years.ago)
      )
    end
  end

end
