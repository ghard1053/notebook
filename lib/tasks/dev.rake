namespace :dev do
  desc "Configura"
  task setup: :environment do

    puts "rails db:drop db:create db:migrate"
    %x(rails db:drop db:create db:migrate)

    puts "create kinds..."

    kinds = %w(Amigo Comercial Conhecido)

    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end

    puts "create kinds succeeded"

    puts "create contact..."

    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(65.years.ago, 18.years.ago),
        kind: Kind.all.sample
      )
    end

    puts "create contact succeeded"

    puts "create phone..."

    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        phone = Phone.create!(number:Faker::PhoneNumber.cell_phone)
        contact.phones << phone
        contact.save!
      end
    end

    puts "create phone succeeded"

    puts "create address..."

    Contact.all.each do |contact|
      address = Address.create(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end

    puts "create address succeeded"

  end
end
