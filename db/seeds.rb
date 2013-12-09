# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: "Gandhi", description: "This awe-inspiring biopic about Mahatma Gandhi -- the diminutive lawyer who stood up against British rule in India and became an international symbol of nonviolence and understanding -- brilliantly underscores the difference one person can make.", small_cover_url: 'tmp/gandhi.png', large_cover_url: 'tmp/gandhi_large.jpg')
Video.create(title: "Reds", description: "Radical journalist and socialist John Reed (Warren Beatty), along with his paramour, protofeminist Louise Bryant (Diane Keaton), gets swept up in the world-changing spirit, euphoria and aftermath of Russia's 1917 Bolshevik Revolution and the newly founded Soviet Union. Jack Nicholson, Paul Sorvino, Edward Herrmann, M. Emmet Walsh and Maureen Stapleton co-star in this Beatty-directed, Oscar-winning epic.", small_cover_url: 'tmp/reds.jpg', large_cover_url: 'tmp/reds_large.jpg')
Video.create(title: "Dr. Zhivago", description: "As political turmoil rumbles through Russia, Doctor Zhivago is trapped in a love triangle between his wife and his mistress. Meanwhile, the Bolshevik Revolution will change all their lives forever in this miniseries remake of the classic 1965 film.", small_cover_url: 'tmp/drzhivago.png', large_cover_url: 'tmp/drzhivago_large.jpg')