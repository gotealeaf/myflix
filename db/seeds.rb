# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

paquito = User.create(email: "paq@paq.com", full_name: "Paquito", password: "12345678", password_confirmation: "12345678", full_name: "Paquito")
curro = Video.create(title: "Curro Jimenez", description: "Brasas brasas brasas.", small_cover: "/tmp/family_guy.jpg", large_cover: "tmp/mok_large.jpg" )
Review.create(creator: paquito, video: curro, rating: 5, content: "Really good serie.")
Review.create(creator: paquito, video: curro, rating: 3, content: "Not that good.")

