# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Categories

comedies = Category.create(name: "TV Comedies")
dramas = Category.create(name: "TV Dramas")

#Videos

v1 = Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "http://dummyimage.com/665x375/000000/00a2ff", categories: [comedies])
v2 = Video.create(title: "South Park", description: "Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "http://dummyimage.com/665x375/000000/00a2ff", categories: [comedies])
v3 = Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "http://dummyimage.com/665x375/000000/00a2ff", categories: [comedies])
v4 = Video.create(title: "South Park", description: "Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "http://dummyimage.com/665x375/000000/00a2ff", categories: [comedies])
v5 = Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "http://dummyimage.com/665x375/000000/00a2ff", categories: [comedies])
v6 = Video.create(title: "South Park", description: "Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "http://dummyimage.com/665x375/000000/00a2ff", categories: [comedies])
v7 = Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "http://dummyimage.com/665x375/000000/00a2ff", categories: [comedies])
v8 = Video.create(title: "South Park", description: "Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "http://dummyimage.com/665x375/000000/00a2ff", categories: [comedies])

v9 = Video.create(title: "Monk", description: "Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", categories: [dramas])
v10 = Video.create(title: "Monk", description: "Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", categories: [dramas])
v11 = Video.create(title: "Monk", description: "Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", categories: [dramas])

#Users
zac = User.create(email: "zacclay@gmail.com", full_name: "Zac Clay", password: "password")
user2 = Fabricate(:user)

#Reviews
review1 = Fabricate(:review, user: zac, video: v9)
review2 = Fabricate(:review, user: user2, video: v9)