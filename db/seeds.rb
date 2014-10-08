# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: "ljconley@gmail.com", password: "ladybird", full_name: "Larissa Conley")
User.create(email: "playpussnut@gmail.com", password: "platty", full_name: "Charles Fournier")
User.create(email: "caleb.conley@gmail.com", password: "mario", full_name: "Caleb Conley")