# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Category.create(:name => "Comedy")
Category.create(:name => "Drama")


3.times do |i|
  Video.create(:title => "South Park", :description => "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network.",
               :small_cover_url => "/tmp/south_park.jpg",
               :large_cover_url => "/tmp/south_park_large.png", 
               :category_id => 1)
end

3.times do |i|
  Video.create(:title => "Monk", :description => "Monk is an American comedy-drama detective mystery television series created by Andy Breckman and starring Tony Shalhoub as the eponymous character.", 
               :small_cover_url => "/tmp/monk.jpg",
               :large_cover_url => "/tmp/monk_large.jpg", 
               :category_id => 2)
end
