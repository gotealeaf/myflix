# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
video1 = Video.create(title: 'Monk', 
                      description: 'Monk is an American \
                        comedy-drama detective mystery television series \
                        created by Andy Breckman and starring Tony Shalhoub \
                        as the eponymous character, Adrian Monk.',
                      url: 'public/tmp/monk.jpg',
                      url_large: 'public/tmp/monk_large.jpg')

video2 = Video.create(title: 'Family Guy', 
                      description: 'Family Guy is an American adult animated \
                        sitcom created by Seth MacFarlane for the Fox \
                        Broadcasting Company.',
                      url: 'public/tmp/family_guy.jpg')

video3 = Video.create(title: 'Futurama', 
                      description: 'Futurama is an American adult animated \
                        science fiction sitcom created by Matt Groening \
                        and developed by Groening and David X. Cohen for \
                        the Fox Broadcasting Company.',
                      url: 'public/tmp/futurama.jpg')