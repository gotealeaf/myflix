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


Loose_Change = Video.create(
title:'Loose Change Final Cut',
description:'Loose Change Final Cut is the third installment of the documentary that asks the tough questions about the 9/11 attacks and related events',
small_cover_url:'tmp/loose_change.jpg',
large_cover_url:'tmp/loose_change_large.jpg',
category: documentaries)

Futurama = Video.create(
title: 'Futurama', 
description: 'A pizza delivery boy named Fry accidentally gets cryogenically frozen and awakens in the year 3000', 
small_cover_url: 'tmp/futurama.jpg', 
large_cover_url: 'tmp/futurama.jpg', 
category: comedies)

Monk = Video.create(
title: 'Monk', 
description: 'A funny show about an OCD Detective', 
small_cover_url: 'tmp/monk.jpg', 
large_cover_url: 'tmp/monk_large.jpg', 
category: dramas)

South_Park = Video.create(
title: 'South Park', 
description: 'The animated exploits of four foul mouthed kids in the crazy small town of South Park, Colorado', 
small_cover_url: 'tmp/south_park.jpg', 
large_cover_url: 'tmp/south_park.jpg', 
category: comedies)

Family_Guy = Video.create(
title: 'Family Guy', 
description: 'Hilarious animated sitcom about a truly dysfunctional family from Quahog, Rhode Island', 
small_cover_url: 'tmp/family_guy.jpg', 
large_cover_url: 'tmp/family_guy.jpg', 
category: comedies)

