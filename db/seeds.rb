require "faker"
100.times do
  User.create(email: Faker::Internet.email, full_name: Faker::Name.name, password: '00001111', password_confirmation: '00001111')
end
