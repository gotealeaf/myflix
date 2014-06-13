# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

drama = Category.create(name: "Drama")
comedy = Category.create(name: "Comedy")
action = Category.create(name: "Action")

Video.create(
  title: "Orange is the New Black", 
  description: "Jailhouse drama.", 
  small_cover_url: "/tmp/orange-is-the-new-black.jpg",
  large_cover_url: "/tmp/orange-is-the-new-black-large.jpg",
  category: drama)

Video.create(
  title: "House of Cards", 
  description: "Murder on capitol hill.", 
  small_cover_url: "/tmp/house-of-cards.jpg",
  large_cover_url: "/tmp/house-of-cards-large.jpg",
  category: drama)

Video.create(
  title: "Brooklyn Nine Nine",
  description: "Anther cop show, only this one's hilarious!",
  small_cover_url: "/tmp/brooklyn-nine-nine.jpg",
  large_cover_url: "/tmp/brooklyn-nine-nine-large.jpg",
  category: comedy)

Video.create(
  title: "Revolution",
  description: "Everyone in the world forgot to pay their electric bill.",
  small_cover_url: "/tmp/revolution.jpg",
  large_cover_url: "/tmp/revolution-large.jpg",
  category: action)