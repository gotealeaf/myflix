# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

action = Genre.create!(name: 'action', slug: 'action')

scifi = Genre.create!(name: 'sciFi', slug: 'scifi')

comedy = Genre.create!(name: 'comedy', slug: 'comedy')

Video.create(name: 'gladiator',
             genre: action,
             slug: 'gladiator',
             duration: '171',
             year: '2000',
             large_cover: 'gladiator_lrg.jpg',
             small_cover: 'gladiator_sml.jpg',
             description: "a man robbed of his name and his dignity strives to win them back, and gain the freedom of his people, in this epic historical drama from director Ridley Scott. In the year 180, the death of emperor Marcus Aurelius (Richard Harris) throws the Roman Empire into chaos. Maximus (Russell Crowe) is one of the Roman army's most capable and trusted generals and a key advisor to the emperor. As Marcus' devious son Commodus (Joaquin Phoenix) ascends to the throne, Maximus is set to be executed. He escapes, but is captured by slave traders. Renamed Spaniard and forced to become a gladiator, Maximus must battle to the death with other men for the amusement of paying audiences. His battle skills serve him well, and he becomes one of the most famous and admired men to fight in the Colosseum. Determined to avenge himself against the man who took away his freedom and laid waste to his family, Maximus believes that he can use his fame and skill in the ring to avenge the loss of his family and former glory. As the gladiator begins to challenge his rule, Commodus decides to put his own fighting mettle to the test by squaring off with Maximus in a battle to the death. Gladiator also features Derek Jacobi, Connie Nielsen, Djimon Hounsou, and Oliver Reed, who died of a heart attack midway through production. ~ Mark Deming, Rovi")
Video.create(name: 'gladiator 2',
             genre: action,
             slug: 'gladiator_2',
             duration: '171',
             year: '2000',
             large_cover: 'gladiator_lrg.jpg',
             small_cover: 'gladiator_sml.jpg',
             description: "a man robbed of his name and his dignity strives to win them back, and gain the freedom of his people, in this epic historical drama from director Ridley Scott. In the year 180, the death of emperor Marcus Aurelius (Richard Harris) throws the Roman Empire into chaos. Maximus (Russell Crowe) is one of the Roman army's most capable and trusted generals and a key advisor to the emperor. As Marcus' devious son Commodus (Joaquin Phoenix) ascends to the throne, Maximus is set to be executed. He escapes, but is captured by slave traders. Renamed Spaniard and forced to become a gladiator, Maximus must battle to the death with other men for the amusement of paying audiences. His battle skills serve him well, and he becomes one of the most famous and admired men to fight in the Colosseum. Determined to avenge himself against the man who took away his freedom and laid waste to his family, Maximus believes that he can use his fame and skill in the ring to avenge the loss of his family and former glory. As the gladiator begins to challenge his rule, Commodus decides to put his own fighting mettle to the test by squaring off with Maximus in a battle to the death. Gladiator also features Derek Jacobi, Connie Nielsen, Djimon Hounsou, and Oliver Reed, who died of a heart attack midway through production. ~ Mark Deming, Rovi")
Video.create(name: 'gladiator 3',
             genre: action,
             slug: 'gladiator_3',
             duration: '171',
             year: '2000',
             large_cover: 'gladiator_lrg.jpg',
             small_cover: 'gladiator_sml.jpg',
             description: "a man robbed of his name and his dignity strives to win them back, and gain the freedom of his people, in this epic historical drama from director Ridley Scott. In the year 180, the death of emperor Marcus Aurelius (Richard Harris) throws the Roman Empire into chaos. Maximus (Russell Crowe) is one of the Roman army's most capable and trusted generals and a key advisor to the emperor. As Marcus' devious son Commodus (Joaquin Phoenix) ascends to the throne, Maximus is set to be executed. He escapes, but is captured by slave traders. Renamed Spaniard and forced to become a gladiator, Maximus must battle to the death with other men for the amusement of paying audiences. His battle skills serve him well, and he becomes one of the most famous and admired men to fight in the Colosseum. Determined to avenge himself against the man who took away his freedom and laid waste to his family, Maximus believes that he can use his fame and skill in the ring to avenge the loss of his family and former glory. As the gladiator begins to challenge his rule, Commodus decides to put his own fighting mettle to the test by squaring off with Maximus in a battle to the death. Gladiator also features Derek Jacobi, Connie Nielsen, Djimon Hounsou, and Oliver Reed, who died of a heart attack midway through production. ~ Mark Deming, Rovi")
Video.create(name: 'gladiator 4',
             genre: action,
             slug: 'gladiator_4',
             duration: '171',
             year: '2000',
             large_cover: 'gladiator_lrg.jpg',
             small_cover: 'gladiator_sml.jpg',
             description: "a man robbed of his name and his dignity strives to win them back, and gain the freedom of his people, in this epic historical drama from director Ridley Scott. In the year 180, the death of emperor Marcus Aurelius (Richard Harris) throws the Roman Empire into chaos. Maximus (Russell Crowe) is one of the Roman army's most capable and trusted generals and a key advisor to the emperor. As Marcus' devious son Commodus (Joaquin Phoenix) ascends to the throne, Maximus is set to be executed. He escapes, but is captured by slave traders. Renamed Spaniard and forced to become a gladiator, Maximus must battle to the death with other men for the amusement of paying audiences. His battle skills serve him well, and he becomes one of the most famous and admired men to fight in the Colosseum. Determined to avenge himself against the man who took away his freedom and laid waste to his family, Maximus believes that he can use his fame and skill in the ring to avenge the loss of his family and former glory. As the gladiator begins to challenge his rule, Commodus decides to put his own fighting mettle to the test by squaring off with Maximus in a battle to the death. Gladiator also features Derek Jacobi, Connie Nielsen, Djimon Hounsou, and Oliver Reed, who died of a heart attack midway through production. ~ Mark Deming, Rovi")
Video.create(name: 'gladiator 5',
             genre: action,
             slug: 'gladiator_5',
             duration: '171',
             year: '2000',
             large_cover: 'gladiator_lrg.jpg',
             small_cover: 'gladiator_sml.jpg',
             description: "a man robbed of his name and his dignity strives to win them back, and gain the freedom of his people, in this epic historical drama from director Ridley Scott. In the year 180, the death of emperor Marcus Aurelius (Richard Harris) throws the Roman Empire into chaos. Maximus (Russell Crowe) is one of the Roman army's most capable and trusted generals and a key advisor to the emperor. As Marcus' devious son Commodus (Joaquin Phoenix) ascends to the throne, Maximus is set to be executed. He escapes, but is captured by slave traders. Renamed Spaniard and forced to become a gladiator, Maximus must battle to the death with other men for the amusement of paying audiences. His battle skills serve him well, and he becomes one of the most famous and admired men to fight in the Colosseum. Determined to avenge himself against the man who took away his freedom and laid waste to his family, Maximus believes that he can use his fame and skill in the ring to avenge the loss of his family and former glory. As the gladiator begins to challenge his rule, Commodus decides to put his own fighting mettle to the test by squaring off with Maximus in a battle to the death. Gladiator also features Derek Jacobi, Connie Nielsen, Djimon Hounsou, and Oliver Reed, who died of a heart attack midway through production. ~ Mark Deming, Rovi")
Video.create(name: 'gladiator 6',
             genre: action,
             slug: 'gladiator_6',
             duration: '171',
             year: '2000',
             large_cover: 'gladiator_lrg.jpg',
             small_cover: 'gladiator_sml.jpg',
             description: "a man robbed of his name and his dignity strives to win them back, and gain the freedom of his people, in this epic historical drama from director Ridley Scott. In the year 180, the death of emperor Marcus Aurelius (Richard Harris) throws the Roman Empire into chaos. Maximus (Russell Crowe) is one of the Roman army's most capable and trusted generals and a key advisor to the emperor. As Marcus' devious son Commodus (Joaquin Phoenix) ascends to the throne, Maximus is set to be executed. He escapes, but is captured by slave traders. Renamed Spaniard and forced to become a gladiator, Maximus must battle to the death with other men for the amusement of paying audiences. His battle skills serve him well, and he becomes one of the most famous and admired men to fight in the Colosseum. Determined to avenge himself against the man who took away his freedom and laid waste to his family, Maximus believes that he can use his fame and skill in the ring to avenge the loss of his family and former glory. As the gladiator begins to challenge his rule, Commodus decides to put his own fighting mettle to the test by squaring off with Maximus in a battle to the death. Gladiator also features Derek Jacobi, Connie Nielsen, Djimon Hounsou, and Oliver Reed, who died of a heart attack midway through production. ~ Mark Deming, Rovi")
Video.create(name: 'gladiator 7',
             genre: action,
             slug: 'gladiator_7',
             duration: '171',
             year: '2000',
             large_cover: 'gladiator_lrg.jpg',
             small_cover: 'gladiator_sml.jpg',
             description: "a man robbed of his name and his dignity strives to win them back, and gain the freedom of his people, in this epic historical drama from director Ridley Scott. In the year 180, the death of emperor Marcus Aurelius (Richard Harris) throws the Roman Empire into chaos. Maximus (Russell Crowe) is one of the Roman army's most capable and trusted generals and a key advisor to the emperor. As Marcus' devious son Commodus (Joaquin Phoenix) ascends to the throne, Maximus is set to be executed. He escapes, but is captured by slave traders. Renamed Spaniard and forced to become a gladiator, Maximus must battle to the death with other men for the amusement of paying audiences. His battle skills serve him well, and he becomes one of the most famous and admired men to fight in the Colosseum. Determined to avenge himself against the man who took away his freedom and laid waste to his family, Maximus believes that he can use his fame and skill in the ring to avenge the loss of his family and former glory. As the gladiator begins to challenge his rule, Commodus decides to put his own fighting mettle to the test by squaring off with Maximus in a battle to the death. Gladiator also features Derek Jacobi, Connie Nielsen, Djimon Hounsou, and Oliver Reed, who died of a heart attack midway through production. ~ Mark Deming, Rovi")
Video.create(name: 'shaun of the Dead',
             genre: comedy,
             slug: 'shaun_of_the_dead',
             duration: '97', year: '2004',
             large_cover: 'sotd_lrg.jpg',
             small_cover: 'sotd_sml.jpg',
             description: "it's often said that the true character of a man is only revealed in times of dire crisis, and for likable, lovelorn loser Shaun (Simon Pegg), that moment of reckoning came when the dead rose from their slumber to feast on the flesh of the living. A hapless electronics store employee who spends most of his spare time downing pints at the local pub with his roommate, Ed (Nick Frost), Shaun's life seems to fall apart when he is dumped by his girlfriend, Liz (Kate Ashfield), and his obnoxious stepfather, Philip (Bill Nighy), shows up to berate him for not being more attentive to his caring mother Barbara (Penelope Wilton) -- especially since he forgot to send flowers for her birthday. Things take a turn for the worse when the dead return to stake their claim on the Earth, and though the chaos that follows threatens to swallow up all of England, it's up to Shaun to keep his cool and prove himself once and for all by successfully rescuing Liz and his mother. With his trusty roommate by his side, nothing -- not even the living dead -- can stand between Shaun and the two most important women in his life. ~ Jason Buchanan, Rovi")

Video.create(name: 'avatar',
             genre: scifi,
             slug: 'avatar',
             duration: '162',
             year: '2009',
             large_cover: 'avatar_lrg.jpg',
             small_cover: 'avatar_sml.jpg',
             description: "avatar is the story of an ex-Marine who finds himself thrust into hostilities on an alien planet filled with exotic life forms. As an Avatar, a human mind in an alien body, he finds himself torn between two worlds, in a desperate fight for his own survival and that of the indigenous people.")
