# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

drama = Category.create(name: "Drama")
crime = Category.create(name: "Crime")
adventure = Category.create(name: "Adventure")

3.times.each do
  Video.create(title: "Life of Pi", description: "A young man who survives a disaster at sea is hurtled into an epic journey of adventure and discovery. While cast away, he forms an unexpected connection with another survivor: a fearsome Bengal tiger.",
    small_cover_url: "/videos/life_of_pi_small.jpg", large_cover_url: "/videos/life_of_pi_large.jpg", category: adventure)
  Video.create(title: "Fight Club", description: "An insomniac office worker looking for a way to change his life crosses paths with a devil-may-care soap maker and they form an underground fight club that evolves into something much, much more...",
    small_cover_url: "/videos/fight_club_small.jpg", large_cover_url: "/videos/fight_club_large.jpg", category: drama)
  Video.create(title: "The Shawshank Redemption", description: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
    small_cover_url: "/videos/the_shawshank_redemption_small.jpg", large_cover_url: "/videos/the_shawshank_redemption_large.jpg", category: crime)
  Video.create(title: "The Pursuit of Happyness", description: "A struggling salesman takes custody of his son as he's poised to begin a life-changing professional endeavor.",
    small_cover_url: "/videos/the_pursuit_of_happyness_small.jpg", large_cover_url: "/videos/the_pursuit_of_happyness_large.jpg", category: drama)
end
Video.create(title: "Fight Club", description: "An insomniac office worker looking for a way to change his life crosses paths with a devil-may-care soap maker and they form an underground fight club that evolves into something much, much more...",
small_cover_url: "/videos/fight_club_small.jpg", large_cover_url: "/videos/fight_club_large.jpg", category: drama)