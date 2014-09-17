# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

    cartoon = Category.create(name: 'Cartoon')
    mystery = Category.create(name: 'Mystery')

    Video.create(title: 'Monk', description: "A very clever TV show", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: mystery)
    Video.create(title: 'Conk', description: "A very conky TV show", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: mystery)
    Video.create(title: 'Future Family', description: "Family guy in the future", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/south_park.jpg", category: cartoon)

    User.create(email: 'rick.heller@yahoo.com', full_name: "Rick Heller", password: "password")
    User.create(email: 'seeingtheroses@gmail.com', full_name: "Harry Jones", password: "password")


    Review.create(rating: 4, description: "Almost fabulous", video_id: 1, user_id: 1)
    Review.create(rating: 2, description: "Sucked", video_id: 1, user_id: 2)

    QueueItem.create(position: 1, video_id: 1, user_id: 1)
    QueueItem.create(position: 2, video_id: 2, user_id: 1)

    Relationship.create(leader_id: 2, follower_id: 1)
