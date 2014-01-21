# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: 'Breaking Bad - Pilot',
             description: 'A mild mannered teacher of high school chemistry learns he' +
                          'has contracted lung cancer and decides to undertake a new ' +
                          'career in the manufacture of crystal meth as a way of ' +
                          'guaranteeing financial solvency for his wife and son' +
                          'after his death.',
             small_cover_url: '/covers/breaking_bad_small.jpg',
             large_cover_url: '/covers/breaking_bad_large.jpg'
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
             large_cover_url: '/covers/dexter_large.jpg'
)

Video.create(title: 'Sons of Anarchy - Pilot',
             description: 'Jax begins to doubt the club after a string of lawlessness hits the town. Meanwhile, his ' +
                        'life also becomes unstable when he learns his druggy ex-wife has given birth to his son ' +
                        'prematurely.',
             small_cover_url: '/covers/sons_of_anarchy_small.jpg',
             large_cover_url: '/covers/sons_of_anarchy_large.jpg'
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
             large_cover_url: '/covers/game_of_thrones_large.jpg'
)

Video.create(title: 'Homeland - Pilot',
             description: 'In the opener of this "Manchurian Candidate"-like political thriller, a marine (Damian ' +
                        'Lewis) rescued after eight years as a POW in Afghanistan returns home a war hero. But a ' +
                        'CIA operative (Claire Danes) suspects he may actually be an enemy agent with a connection ' +
                        'to Al Qaeda and part of a plan to commit a terrorist act on U.S. soil.',
             small_cover_url: '/covers/homeland_small.jpg',
             large_cover_url: '/covers/homeland_large.jpg'
)

Video.create(title: 'Sherlock - A Study in Pink',
             description: 'A woman dressed in pink is discovered dead in a derelict house, the fourth in a series of ' +
                          'odd suicides. Sherlock and John end up trying to solve cryptic clues and have to deal ' +
                          'with a lethal killer in their quest to discover the truth.',
             small_cover_url: '/covers/sherlock_small.jpg',
             large_cover_url: '/covers/sherlock_large.jpg'
)
