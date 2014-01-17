# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



comedies = Category.create(name: 'Comedies')
dramas = Category.create(name: 'Dramas')
reality = Category.create(name: 'Reality')
documentaries = Category.create(name: 'Documentaries')
scifi = Category.create(name:'Scifi')

Loose_Change = Video.create(
title:'Loose Change Final Cut',
description:'Loose Change Final Cut is the third installment of the documentary that asks the tough questions about the 9/11 attacks and related events',
small_cover_url:'/tmp/loose_change.jpg',
large_cover_url:'/tmp/loose_change_large.jpg',
category: documentaries)

Futurama = Video.create(
title: 'Futurama', 
description: 'A pizza delivery boy named Fry accidentally gets cryogenically frozen and awakens in the year 3000', 
small_cover_url: '/tmp/futurama.jpg', 
large_cover_url: '/tmp/futurama.jpg', 
category: comedies)

Monk = Video.create(
title: 'Monk', 
description: 'A funny show about an OCD Detective', 
small_cover_url: '/tmp/monk.jpg', 
large_cover_url: '/tmp/monk_large.jpg', 
category: dramas)

South_Park = Video.create(
title: 'South Park', 
description: 'The animated exploits of four foul mouthed kids in the crazy small town of South Park, Colorado', 
small_cover_url: '/tmp/south_park.jpg', 
large_cover_url: '/tmp/south_park.jpg', 
category: comedies)

Family_Guy = Video.create(
title: 'Family Guy', 
description: 'Hilarious animated sitcom about a truly dysfunctional family from Quahog, Rhode Island', 
small_cover_url: '/tmp/family_guy.jpg', 
large_cover_url: '/tmp/family_guy.jpg', 
category: comedies)

Fringe = Video.create(
title: 'Fringe', 
description: 'Fringe is an American science fiction television series created by J. J. Abrams, Alex Kurtzman, and Roberto Orci', 
small_cover_url: '/tmp/fringe.jpg', 
large_cover_url: '/tmp/fringe_large.jpg', 
category: scifi)

Modern_Family = Video.create(
title: 'Modern Family', 
description: 'Told from the perspective of an unseen documentary filmmaker, the series offers an honest and often hilarious perspective of family life', 
small_cover_url: '/tmp/modern_family.jpg', 
large_cover_url: '/tmp/modern_family_large.jpg', 
category: comedies)

Big_Bang_Theory = Video.create(
title: 'Big Bang Theory', 
description: 'The Big Bang Theory is a comedy series about four young scientists who know all about the world of physics, and one girl', 
small_cover_url: '/tmp/big_bang_theory.jpg', 
large_cover_url: '/tmp/big_bang_theory_large.jpg', 
category: comedies)

How_I_Met_Your_Mother = Video.create(
title: 'How I Met Your Mother', 
description: 'Sitcom series that follows main character, Ted Mosby, and his group of friends in Manhattan', 
small_cover_url: '/tmp/met_mother.jpg', 
large_cover_url: '/tmp/met_mother_large.jpg', 
category: comedies)

Burning_Love = Video.create(
title: 'Burning Love', 
description: 'A scripted comedy series which is a web spoof of the television shows The Bachelor, The Bachelorette and Bachelor Pad', 
small_cover_url: '/tmp/burning_love.jpg', 
large_cover_url: '/tmp/burning_love_large.jpg', 
category: comedies)

mark = User.create(full_name:'Mark Hustad', password:'123', email:'mark@hustad.com')

Review.create(user: mark, video: Fringe, rating: 4, content: "Awesome scifi show")

