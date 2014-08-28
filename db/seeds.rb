# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
series_scify   = Category.create(name: 'Science Fiction Series')
series_history = Category.create(name: 'History Based Series')

Video.create(
  title: 'Vikings',
  description: 'The series is inspired by the tales of the raiding, trading, and exploring Norsemen of early medieval Scandinavia. It follows the exploits of the legendary Viking chieftain Ragnar Lothbrok and his crew and family, as notably laid down in the 13th century sagas Ragnars saga Loðbrókar and Ragnarssona þáttr.',
  small_cover_url: '/tmp/vikings.jpg', 
  large_cover_url: '/tmp/image_place_holder.jpg',
  category_id: series_history)
Video.create(
  title: 'Star Trek',
  description: 'Star Trek is an American science fiction entertainment franchise created by Gene Roddenberry and currently under the ownership of CBS and Paramount.',
  small_cover_url: '/tmp/star_trek.jpg', 
  large_cover_url: '/tmp/image_place_holder.jpg',
  category: series_scify)
Video.create(
  title: 'Sherlock',
  description: 'Sherlock is a British television crime drama that presents a contemporary adaptation of Sir Arthur Conan Doyle\'s Sherlock Holmes detective stories.',
  small_cover_url: '/tmp/sherlock.jpg', 
  large_cover_url: '/tmp/image_place_holder.jpg',
  category: series_history)
Video.create(
  title: 'Stargate',
  description: 'Stargate is an adventure military science fiction franchise, initially conceived by Roland Emmerich and Dean Devlin. The first film in the franchise was simply titled Stargate.',
  small_cover_url: '/tmp/stargate.jpg', 
  large_cover_url: '/tmp/image_place_holder.jpg',
  category: series_scify)
Video.create(
  title: 'Vikings',
  description: 'The series is inspired by the tales of the raiding, trading, and exploring Norsemen of early medieval Scandinavia. It follows the exploits of the legendary Viking chieftain Ragnar Lothbrok and his crew and family, as notably laid down in the 13th century sagas Ragnars saga Loðbrókar and Ragnarssona þáttr.',
  small_cover_url: '/tmp/vikings.jpg', 
  large_cover_url: '/tmp/image_place_holder.jpg',
  category_id: series_history)
Video.create(
  title: 'Star Trek',
  description: 'Star Trek is an American science fiction entertainment franchise created by Gene Roddenberry and currently under the ownership of CBS and Paramount.',
  small_cover_url: '/tmp/star_trek.jpg', 
  large_cover_url: '/tmp/image_place_holder.jpg',
  category: series_scify)
Video.create(
  title: 'Sherlock',
  description: 'Sherlock is a British television crime drama that presents a contemporary adaptation of Sir Arthur Conan Doyle\'s Sherlock Holmes detective stories.',
  small_cover_url: '/tmp/sherlock.jpg', 
  large_cover_url: '/tmp/image_place_holder.jpg',
  category: series_history)
Video.create(
  title: 'Stargate',
  description: 'Stargate is an adventure military science fiction franchise, initially conceived by Roland Emmerich and Dean Devlin. The first film in the franchise was simply titled Stargate.',
  small_cover_url: '/tmp/stargate.jpg', 
  large_cover_url: '/tmp/image_place_holder.jpg',
  category: series_scify)
Video.create(
  title: 'Vikings',
  description: 'The series is inspired by the tales of the raiding, trading, and exploring Norsemen of early medieval Scandinavia. It follows the exploits of the legendary Viking chieftain Ragnar Lothbrok and his crew and family, as notably laid down in the 13th century sagas Ragnars saga Loðbrókar and Ragnarssona þáttr.',
  small_cover_url: '/tmp/vikings.jpg', 
  large_cover_url: '/tmp/image_place_holder.jpg',
  category_id: series_history)
Video.create(
  title: 'Star Trek',
  description: 'Star Trek is an American science fiction entertainment franchise created by Gene Roddenberry and currently under the ownership of CBS and Paramount.',
  small_cover_url: '/tmp/star_trek.jpg', 
  large_cover_url: '/tmp/image_place_holder.jpg',
  category: series_scify)
Video.create(
  title: 'Sherlock',
  description: 'Sherlock is a British television crime drama that presents a contemporary adaptation of Sir Arthur Conan Doyle\'s Sherlock Holmes detective stories.',
  small_cover_url: '/tmp/sherlock.jpg', 
  large_cover_url: '/tmp/image_place_holder.jpg',
  category: series_history)
Video.create(
  title: 'Stargate',
  description: 'Stargate is an adventure military science fiction franchise, initially conceived by Roland Emmerich and Dean Devlin. The first film in the franchise was simply titled Stargate.',
  small_cover_url: '/tmp/stargate.jpg', 
  large_cover_url: '/tmp/image_place_holder.jpg',
  category: series_scify)
Video.create(
  title: 'Stargate',
  description: 'Stargate is an adventure military science fiction franchise, initially conceived by Roland Emmerich and Dean Devlin. The first film in the franchise was simply titled Stargate.',
  small_cover_url: '/tmp/stargate.jpg', 
  large_cover_url: '/tmp/image_place_holder.jpg',
  category: series_scify)

aj = User.create(full_name: "AJ Jones", password: "password", email: "aj@example.com")

Review.create(user: aj, video: stargate, rating: 5, content: "Wow, what a show.")
Review.create(user: aj, video: stargate, rating: 2, content: "It's really just ok. Don't waste your time.")