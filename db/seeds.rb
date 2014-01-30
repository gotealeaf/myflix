# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

animated = Category.create(name: 'Animated')
fantasy = Category.create(name: 'Fantasy')
comedy = Category.create(name: 'Comedy')

Video.create(title: 'Despicable Me 2', category: animated, description: 'Gru, his adorable girls, and the mischievous Minions are back with a cast of unforgettable new characters in the blockbuster sequel to the worldwide phenomenon. Just as Gru has given up being super-bad to be a super-dad, the Anti-Villain League recruits him to track down a new criminal mastermind and save the world. Partnered with secret agent Lucy Wilde, Gru, along with the wildly unpredictable Minions, must figure out how to keep his cover while also keeping up with his duties as a father. Assemble the Minions for laugh-out-loud comedy in “one of the funniest, most enjoyable movies ever!” (MovieGuide®)', small_cover_url: 'http://a5.mzstatic.com/us/r30/Video4/v4/52/ba/51/52ba5147-750a-39d6-97bc-fb18f4af0132/mza_5839438706005633446.227x227-75.jpg'
7.times {Video.create( category: fantasy, title: 'The Hobbit: An Unexpected Journey', description: 'The adventure follows Bilbo Baggins, who is swept into an epic quest to reclaim Erebor with the help of Gandalf the Grey and 13 Dwarves led by the legendary warrior, Thorin Oakenshield. Their journey will take them into the wild, through treacherous lands swarming with Goblins, Orcs and deadly Wargs, as well as a mysterious and sinister figure known only as the Necromancer. Although their goal lies to the East and the wastelands of the Lonely Mountain, first they must escape the Goblin tunnels, where Bilbo meets the creature that will change his life forever...Gollum. Here, alone with Gollum, on the shores of an underground lake, the unassuming Bilbo Baggins not only discovers depths of ingenuity and courage that surprise even him, he also gains  ', small_cover_url: 'http://a4.mzstatic.com/us/r30/Video/v4/24/93/e0/2493e096-97d0-e6b4-4eca-d1b069a7a518/mza_4646623078256410151.227x227-75.jpg', large_cover_url: 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTdBv-tBbKV5ftIgsDZ5tP7vcDdnG4Iz27VE3Schzv6GGYog1n9Ig')}
bird_flick = Video.create(title: 'Rio ', category: animated, description: 'RIO is an animated feature from the makers of the Ice Age films. Set in the magnificent city of Rio de Janeiro and the lush rain forest of Brazil, this comedy-adventure centers on Blu, a rare macaw who thinks he is the last of his kind. When Blu discovers there’s another – and that she’s a she – he leaves the comforts of his cage in small town Minnesota and heads to Rio. But it’s far from love at first sight between the domesticated and flight-challenged Blu and the fiercely independent, high-flying female, Jewel. Unexpectedly thrown together, they embark on an adventure of a lifetime, where they learn about friendship, love, courage, and being open to life’s many wonders. RIO brings together a menagerie of vivid characters, a heart-warming story, colorful  ', small_cover_url: 'http://images.apple.com/autopush/us/itunes/charts/movies/images/2014/1/f2mzl.goufpdhf.jpg', 

user1  = User.create(full_name: 'Michael', email: 'me@them.com', password: 'password')
user_name = user1.full_name

5.times {Review.create(rating: [2,3,4,5].sample, user: user1, content: "I geve the movie #{bird_flick.title} the rating it deserved.", video: bird_flick )}