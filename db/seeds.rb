# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
comedy = Category.create(name: "comedy")
television = Category.create(name: "television")

video1 = Video.create!(title: 'Monk', 
                      description: 'Monk is an American \
                        comedy-drama detective mystery television series \
                        created by Andy Breckman and starring Tony Shalhoub \
                        as the eponymous character, Adrian Monk.',
                      url: '/tmp/monk.jpg',
                      url_large: '/tmp/monk_large.jpg', category: comedy)

video2 = Video.create!(title: 'Family Guy', 
                      description: 'Family Guy is an American adult animated \
                        sitcom created by Seth MacFarlane for the Fox \
                        Broadcasting Company.',
                      url: '/tmp/family_guy.jpg', category: comedy)

video3 = Video.create!(title: 'Futurama', 
                      description: 'Futurama is an American adult animated \
                        science fiction sitcom created by Matt Groening \
                        and developed by Groening and David X. Cohen for \
                        the Fox Broadcasting Company.',
                      url: '/tmp/futurama.jpg', category: comedy)

video4 = Video.create!(title: 'Orange is the New Black', 
                      description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Atque quis molestiae placeat harum, voluptas, ipsam animi repudiandae a sapiente ipsa iusto reprehenderit asperiores quisquam magni reiciendis qui mollitia necessitatibus itaque.',
                      url: '/tmp/orange_is_the_new_black.jpeg', category: television)

video5 = Video.create!(title: 'Hemlock Grove', 
                      description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Non veritatis eum nulla magni labore hic cumque, ipsum asperiores, dolorem eos quis quasi nemo est, laborum fuga doloribus mollitia ea! Ullam.',
                      url: '/tmp/hemlock_grove.jpeg', category: television)

video6 = Video.create!(title: 'House of Cards', 
                      description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Non veritatis eum nulla magni labore hic cumque, ipsum asperiores, dolorem eos quis quasi nemo est, laborum fuga doloribus mollitia ea! Ullam.',
                      url: '/tmp/house_of_cards.jpeg', category: television)
video5 = Video.create!(title: 'The Killing', 
                      description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Non veritatis eum nulla magni labore hic cumque, ipsum asperiores, dolorem eos quis quasi nemo est, laborum fuga doloribus mollitia ea! Ullam.',
                      url: '/tmp/the_killing.jpeg', category: television)
