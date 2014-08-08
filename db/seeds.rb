require "faker"
  100.times do
  User.create(email: Faker::Internet.email, full_name: Faker::Name.name, password: '00001111', password_confirmation: '00001111')
end

Video.create!(title:"Family Guy",
  description: "American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company.",
  large_cover_image_url: "http://upload.wikimedia.org/wikipedia/en/a/aa/Family_Guy_Logo.svg" ,
  small_cover_image_url: "/tmp/family_guy.jpg",
  category_id: 1 )
Video.create!(title:"Futurama",
  description: "The series follows the adventures of a late-20th-century New York City pizza delivery boy, Philip J. Fry, who, after being unwittingly cryogenically frozen for one thousand years, finds employment at Planet Express, an interplanetary delivery company in the retro-futuristic 31st century.",
  large_cover_image_url: "http://upload.wikimedia.org/wikipedia/en/d/de/Futurama_title_screen.jpg" ,
  small_cover_image_url: "/tmp/futurama.jpg",
  category_id: 1 )
Video.create!(title:"Monk",
description: "A Monk is a person who practices religious asceticism, living either alone or with any number of other monks. A monk may be a person who decided to dedicate ...",
  large_cover_image_url: "/tmp/monk_large.jpg" ,
  small_cover_image_url: "/tmp/monk.jpg",
  category_id: 1)
Video.create!(title:"South Park",
  description: "Watch Cartman, Kenny, Stan and Kyle in all their foul-mouthed adventures. Stream free episodes and clips, play games, create an avatar and go ...",
  large_cover_image_url:"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR9tDbf8PB2mR6V3mOZ6O938hESUbFa3z-zYHo6yTaYO0FgfTug" ,
  small_cover_image_url: "/tmp/south_park.jpg",
  category_id: 1)
Video.create!(title:"The Avengers",
  description: "An all-star lineup of superheroes -- including Iron Man, the Incredible Hulk and Captain America -- team up to save the world from certain doom. Working under the authority of S.H.I.E.L.D., can our heroes keep the planet at peace?",
  large_cover_image_url: "http://cdn-3.nflximg.com/us/boxshots/ghd/70217913.jpg" ,
  small_cover_image_url: "http://cdn-3.nflximg.com/us/boxshots/large/70217913.jpg",
  category_id: 2)
Video.create!(title:"Captain America: The Winter Soldier",
  description: "Extending the saga of Marvel's The Avengers, this superhero sequel finds Steve Rogers living quietly in Washington but growing increasingly restless. So when a deadly new foe surfaces, he transforms into Captain America and allies with Black Widow.",
  large_cover_image_url: "http://cdn-4.nflximg.com/us/boxshots/ghd/70293704.jpg" ,
  small_cover_image_url: "http://cdn-4.nflximg.com/us/boxshots/large/70293704.jpg",
  category_id: 2)
Video.create!(title:"The Dark Knight",
  description: "In this sequel to Batman Begins, the caped crusader teams with Lt. James Gordon and District Attorney Harvey Dent to continue dismantling Gotham City's criminal organizations. But a new villain known as the Joker threatens to undo their good work.",
  large_cover_image_url: "http://cdn-3.nflximg.com/us/boxshots/ghd/70079583.jpg" ,
  small_cover_image_url: "http://cdn-3.nflximg.com/us/boxshots/large/70079583.jpg",
  category_id: 2)
Video.create!(title:"Shark Battlefield",
  description: "What's it like to be a tiger shark, to have extraordinary senses and detect things humans cannot see or feel? The latest in image technology enables us to enter a very different world to our own, revealing in incredible clarity search patterns and attack strategies that show sharks as we've never seen them before.",
  large_cover_image_url: "http://cdn-8.nflximg.com/us/boxshots/ghd/70307058.jpg" ,
  small_cover_image_url: "http://cdn-8.nflximg.com/us/boxshots/large/70307058.jpg",
  category_id: 3)
Video.create!(title:"The Lord of the Rings: The Return of the King",
  description: "In this final chapter, Aragorn is revealed as the heir to the ancient kings as he, Gandalf and the other members of the broken fellowship struggle to save Gondor from Sauron's forces. Meanwhile, Frodo and Sam bring the ring to the heart of Mordor.",
  large_cover_image_url: "http://cdn-4.nflximg.com/us/boxshots/ghd/60004484.jpg" ,
  small_cover_image_url: "http://cdn-4.nflximg.com/us/boxshots/large/60004484.jpg",
  category_id: 3)
Video.create!(title:"The Lord of the Rings: The Fellowship of the Ring",
  description: "From the idyllic shire of the Hobbits to the smoking chasms of Mordor, director Peter Jackson brings the world of J.R.R. Tolkien's novels to life as Frodo Baggins embarks on his epic quest to destroy the ring of Sauron. ",
  large_cover_image_url: "http://cdn-0.nflximg.com/us/boxshots/ghd/60004480.jpg" ,
  small_cover_image_url: "http://cdn-0.nflximg.com/us/boxshots/large/60004480.jpg",
  category_id: 3)
Video.create!(title:"The Lord of the Rings: The Two Towers",
  description: "Frodo and Sam trek to Mordor to destroy the One Ring of Power while Gimli, Legolas and Aragorn search for the orc-captured Merry and Pippin. All along, nefarious wizard Saruman awaits the members of the Fellowship at the Orthanc Tower in Isengard.",
  large_cover_image_url: "http://cdn-3.nflximg.com/us/boxshots/large/60004483.jpg" ,
  small_cover_image_url: "http://cdn-3.nflximg.com/us/boxshots/large/60004483.jpg",
  category_id: 3)
Video.create!(title:"Dance Moms",
  description: "On this competitive reality show, tiny dancers learn the ropes under the demanding tutelage of Abby Lee Miller, owner of Pittsburgh's Abby Lee Dance Company -- and their moms keep a close eye on the kids' budding dance and showbiz careers.",
  large_cover_image_url: "http://cdn-2.nflximg.com/us/boxshots/ghd/70243382.jpg" ,
  small_cover_image_url: "http://cdn-0.nflximg.com/us/boxshots/large/70275780.jpg",
  category_id: 4)
Video.create!(title:"Gone with the Wind",
  description: "Director Victor Fleming's 1939 epic adaption of Margaret Mitchell's novel of the same name stars Vivien Leigh as self-absorbed, headstrong Scarlett O'Hara, a Southern Belle who meets her match in Rhett Butler just as the Civil War breaks out.",
  large_cover_image_url: "http://cdn-4.nflximg.com/us/boxshots/ghd/70020694.jpg" ,
  small_cover_image_url: "http://cdn-4.nflximg.com/us/boxshots/large/70020694.jpg",
  category_id: 4)
