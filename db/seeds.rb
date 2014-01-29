# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

drama = Category.create(name: 'Drama')
comedy = Category.create(name: 'Comedy')
reality= Category.create(name: 'Reality')

Video.create(title: 'Breaking Bad - Pilot',
             description: 'A mild mannered teacher of high school chemistry learns he' +
                          'has contracted lung cancer and decides to undertake a new ' +
                          'career in the manufacture of crystal meth as a way of ' +
                          'guaranteeing financial solvency for his wife and son' +
                          'after his death.',
             small_cover_url: '/covers/breaking_bad_small.jpg',
             large_cover_url: '/covers/breaking_bad_large.jpg',
             category: drama
)

Video.create(title: 'Dexter - Dexter',
             description: 'Dexter Morgan, a Miami Metro Police Department blood spatter analyst, is living a double ' +
                          'life. After his day job with the police department, Dexter moonlights as a serial killer, ' +
                          'hunting and killing criminals who slip through the justice system. Dexter\'s sister, ' +
                          'Debra, a vice squad officer, pulls Dexter into her world when another serial killer is ' +
                          'killing prostitutes and leaving their bloodless bodies dismembered in various locations ' +
                          'around Miami. Meanwhile, Dexter hunts a man who made snuff videos and killed a mother of ' +
                          'two.',
             small_cover_url: '/covers/dexter_small.jpg',
             large_cover_url: '/covers/dexter_large.jpg',
             category: drama
)

Video.create(title: 'Dexter - Crocodile',
             description: 'As Dexter stalks his next victim, a drunk driver who is about to be acquitted for ' +
                          'vehicular homicide that resulted in the death of a teenage boy, the Ice Truck Killer ' +
                          'strikes again and later gets in touch with Dexter. Meanwhile, when a cop is found ' +
                          'murdered, Dexter helps Doakes and Debra investigate a crime boss who they believe is ' +
                          'responsible.',
             small_cover_url: '/covers/dexter_small.jpg',
             large_cover_url: '/covers/dexter_large.jpg',
             category: drama
)

sons_of_anarchy = Video.create(title: 'Sons of Anarchy - Pilot',
             description: 'Jax begins to doubt the club after a string of lawlessness hits the town. Meanwhile, his ' +
                        'life also becomes unstable when he learns his druggy ex-wife has given birth to his son ' +
                        'prematurely.',
             small_cover_url: '/covers/sons_of_anarchy_small.jpg',
             large_cover_url: '/covers/sons_of_anarchy_large.jpg',
             category: drama
)

Video.create(title: 'Game of Thrones - Winter is Coming',
             description: 'A Nights’s Watch deserter is tracked down outside of Winterfell, prompting swift justice ' +
                        'by Lord Eddard “Ned” Stark and raising concerns about the dangers in the lawless lands ' +
                        'north of the Wall. Returning home, Ned learns from his wife Catelyn that his mentor, Jon ' +
                        'Arryn, has died in the Westeros capital of King’s Landing, and that King Robert is on his ' +
                        'way north to offer Ned Arryn’s position as the King’s Hand. Meanwhile, across the ' +
                        'NarrowSeain Pentos, Viserys Targaryen hatches a plan to win back the throne, which ' +
                        'entails forging an allegiance with the nomadic Dothraki warriors by giving its leader, ' +
                        'Khal Drogo, his lovely sister Daenerys’ hand in marriage. Robert arrives at Winterfell ' +
                        'with his wife, Queen Cersei, and other members of the Lannister family: her twin brother ' +
                        'Jaime, dwarf brother Tyrion and Cersei’s son and heir to the throne, 12-year-old ' +
                        'Joffrey. Unable to refuse his old friend and king, Ned prepares to leave for King’s ' +
                        'Landing, as Jon Snow decides to travel north to Castle Black to join the Night’s Watch, ' +
                        'accompanied by a curious Tyrion. But a startling act of treachery directed at young Bran ' +
                        'may postpone their departures.',
             small_cover_url: '/covers/game_of_thrones_small.jpg',
             large_cover_url: '/covers/game_of_thrones_large.jpg',
             category: drama
)

Video.create(title: 'Homeland - Pilot',
             description: 'In the opener of this "Manchurian Candidate"-like political thriller, a marine (Damian ' +
                        'Lewis) rescued after eight years as a POW in Afghanistan returns home a war hero. But a ' +
                        'CIA operative (Claire Danes) suspects he may actually be an enemy agent with a connection ' +
                        'to Al Qaeda and part of a plan to commit a terrorist act on U.S. soil.',
             small_cover_url: '/covers/homeland_small.jpg',
             large_cover_url: '/covers/homeland_large.jpg',
             category: drama
)

Video.create(title: 'Homeland - Grace',
             description: 'Carrie receives a new piece of electronic evidence from an undercover agent while staying ' +
                          "glued to the surveillance footage of life in Brody's home, which reveals a man struggling " +
                          'with his traumatic memories and resisting pressure to become a media hero.',
             small_cover_url: '/covers/homeland_small.jpg',
             large_cover_url: '/covers/homeland_large.jpg',
             category: drama
)

Video.create(title: 'Sherlock - A Study in Pink',
             description: 'A woman dressed in pink is discovered dead in a derelict house, the fourth in a series of ' +
                          'odd suicides. Sherlock and John end up trying to solve cryptic clues and have to deal ' +
                          'with a lethal killer in their quest to discover the truth.',
             small_cover_url: '/covers/sherlock_small.jpg',
             large_cover_url: '/covers/sherlock_large.jpg',
             category: drama
)

Video.create(title: '30 Rock - Pilot',
             description: 'Liz Lemon is living every writer\'s dream -- the head writer for a live variety show that ' +
                          'stars her best friend, Jenna Maroney. But her world is thrown off track when Jack Donaghy ' +
                          'is hired as the new network executive. He begins to interfere with the show and convinces ' +
                          'Liz to hire Tracy Jordan, a wild movie star. Jack later has Liz spend time with Tracy ' +
                          'before she rejects him and she ends up swept up in his entourage.',
             small_cover_url: '/covers/30_rock_small.jpg',
             large_cover_url: '/covers/30_rock_large.jpg',
             category: comedy
)

the_big_bang_theory = Video.create(title: 'The Big Bang Theory - Pilot',
             description: 'Leonard and Sheldon visit a high IQ sperm bank, but have regrets about going, so they ' +
                        'leave, only to feel guilty afterwards. When they arrive back at the apartment, they see a ' +
                        'beautiful blonde woman, Penny, in the apartment across the hallway and they attempt to ' +
                        'befriend her. Sheldon, who has no experience being around someone like Penny, doesn’t ' +
                        'know what to do, while Leonard really takes a shine to her. Meanwhile, Howard makes ' +
                        'numerous attempts to impress Penny, while Koothrappali is too shy to talk to her.',
             small_cover_url: '/covers/the_big_bang_theory_small.jpg',
             large_cover_url: '/covers/the_big_bang_theory_large.jpg',
             category: comedy
)

american_idol = Video.create(title: 'American Idol - Auditions #1 - Boston & Austin',
             description: "Everyone's favorite singing competition returns for its highly anticipated 13th season " +
                        "with a new dream team judging panel, new contestants and the best and worst of auditions. " +
                        "Host Ryan Seacrest and judges Jennifer Lopez, Keith Urban and Harry Connick, Jr., travel " +
                        "across the country to Atlanta, Austin, Boston, Detroit, Omaha, Salt Lake City and San " +
                        "Francisco where the good, the bad and the outrageous audition for their shot at stardom. " +
                        "This season promises to deliver the most talented group of singers yet and as always, " +
                        "it's up to the viewers to root and vote for their favorite contestants, ultimately " +
                        "crowning the next AMERICAN IDOL. Don't miss the auditions from Boston and Austin that " +
                        "everyone will be talking about the next day.",
             small_cover_url: '/covers/american_idol_small.jpg',
             large_cover_url: '/covers/american_idol_large.jpg',
             category: reality
)

Video.create(title: 'American Dad - Pilot',
             description: "Stan rigs the school election so Steve can become school president so he can impress the " +
                          "most popular girl in school, Lisa Silver. Meanwhile, after Francine cuts off Roger's " +
                          "supply of junk food, he agrees to write Hayley's term papers if he continues to supply " +
                          "his fix.",
             small_cover_url: '/covers/american_dad_small.jpg',
             large_cover_url: '/covers/american_dad_large.jpg',
             category: comedy
)

brandon = User.create(email: 'user@email.com', password: 'password', full_name: 'Brandon Conway')

Review.create(rating: 5, body: 'Amazing!', creator: brandon, video: sons_of_anarchy)

Review.create(rating: 2, body: 'Blech!', creator: brandon, video: american_idol)

brandon.queue_items.create(video: american_idol, position: brandon.next_available_position)
brandon.queue_items.create(video: the_big_bang_theory, position: brandon.next_available_position)
brandon.queue_items.create(video: sons_of_anarchy, position: brandon.next_available_position)
