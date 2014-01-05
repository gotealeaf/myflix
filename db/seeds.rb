# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: 'Comedy')
Category.create(name: 'Sci-Fi')
Category.create(name: 'Drama')
Video.create(title: 'Family Guy', description: "In Seth MacFarlane's no-holds-barred animated show, buffoonish Peter Griffin and his dysfunctional family -- including wife Lois, children Meg, Chris and Stewie, and dog Brian -- experience wacky misadventures.", small_cover_url: '/tmp/family_guy.jpg', large_cover_url: '/tmp/family_guy_large.jpg')
Video.create(title: 'Futurama', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/futurama_large.jpg')
Video.create(title: 'Monk', description: "With his job secure and his wife's murder finally solved, Adrian Monk is feeling strangely... satisfied. He'd like his agoraphobic brother Ambrose to feel the same way, so Monk puts a secret ingredient in Ambrose's birthday cake. When Ambrose wakes up, he's in a motor home on the open road with Monk determined to show him the outside world. But Ambrose isn't the only one struggling to let go. Now it's up to Monk to stop a murderer from turning their road trip into a highway to hell.", small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg')
