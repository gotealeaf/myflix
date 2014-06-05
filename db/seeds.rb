# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: 'Futurama', description: 'Futurama is an American adult animated science fiction sitcom created by Matt Groening and developed by Groening and David X. Cohen for the Fox Broadcasting Company. The series follows the adventures of a late-20th-century New York City pizza delivery boy, Philip J. Fry, who, after being unwittingly cryogenically frozen for one thousand years, finds employment at Planet Express, an interplanetary delivery company in the retro-futuristic 31st century. The series was envisioned by Groening in the late 1990s while working on The Simpsons, later bringing Cohen aboard to develop storylines and characters to pitch the show to Fox.', small_cover_url: '/tmp/futurama.jpg')
Video.create(title: 'Monk', description: 'Monk is an American comedy-drama detective mystery television series created by Andy Breckman and starring Tony Shalhoub as the eponymous character, Adrian Monk. It originally ran from 2002 to 2009 and is primarily a police procedural series, and also exhibits comic and dramatic tones in its exploration of the main characters\' personal lives. The series was produced by Mandeville Films and Touchstone Television in association with Universal Television.', small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg')
Video.create(title: 'Family Guy', description: 'Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company. The series centers on the Griffins, a family consisting of parents Peter and Lois; their children Meg, Chris, and Stewie; and their anthropomorphic pet dog Brian. The show is set in the fictional city of Quahog, Rhode Island, and exhibits much of its humor in the form of cutaway gags that often lampoon American culture.', small_cover_url: '/tmp/family_guy.jpg')
