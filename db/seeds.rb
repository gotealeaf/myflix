# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(
  title: "Orange is the New Black", 
  description: "Jailhouse drama.", 
  small_cover_url: "/tmp/orange-is-the-new-black.jpg",
  large_cover_url: "/tmp/orange-is-the-new-black-large.jpg")

Video.create(
  title: "House of Cards", 
  description: "Murder on capitol hill.", 
  small_cover_url: "/tmp/house-of-cards.jpg",
  large_cover_url: "/tmp/house-of-cards-large.jpg")

Video.create(
  title: "Brooklyn Nine Nine", 
  description: "Another cop show, only this one is hilarious!", 
  small_cover_url: "/tmp/brooklyn-nine-nine.jpg",
  large_cover_url: "/tmp/brooklyn-nine-nine-large.jpg")

Video.create(
  title: "Revolution",
  description: "Everyone in the world forgot to pay their electric bill.",
  small_cover_url: "/tmp/revolution.jpg",
  large_cover_url: "/tmp/revolution-large.jpg")