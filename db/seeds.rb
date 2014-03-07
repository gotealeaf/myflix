# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

v1 = Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "http://dummyimage.com/665x375/000000/00a2ff")
v2 = Video.create(title: "South Park", description: "Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "http://dummyimage.com/665x375/000000/00a2ff")
v3 = Video.create(title: "Monk", description: "Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")

com = Category.create(name: "TV Comedies")
dram = Category.create(name: "TV Dramas")

v1.categories << com
v2.categories << com
v3.categories << dram
