# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century 
  after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary 
  delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.",
  small_cover_url: "/tmp/futurama.jpg",large_cover_url: "/tmp/futurama_large.jpg")

  Video.create(title: "Monk", description: "Monk investigates an assassination attempt 
  on a mayoral candidate (Michael Hogan) and learns that there is more at play than meets
  the eye, especially after discovering secrets involving the candidate's wife 
  (Gail O'Grady) and campaign manager (Ben Bass).", small_cover_url: "/tmp/monk.jpg",
  large_cover_url: "/tmp/monk_large.jpg")

  Video.create(title:"Chak de", description: "Chak De! India (English: Go India!) is a 
  2007 Hindi-language Indian sports drama film about field hockey in India. Directed 
  by Shimit Amin and produced by Yash Raj Films, with action by Rob Miller of ReelSports, 
  the film stars Shah Rukh Khan as Kabir Khan, the former captain of the Indian hockey 
  team. In the plot, after a disastrous loss to the Pakistan hockey team, Khan is
  ostracised from the sport. ",small_cover_url: "/tmp/chak_de.jpg", large_cover_url: "/tmp/chak_de_large.jpg")

  Video.create(title: "Thor", description: "In 965 AD, Odin, king of Asgard, wages war 
  against the Frost Giants of Jotunheim and their leader Laufey, to prevent them from 
  conquering the nine realms, starting with Earth. The Asgardian warriors defeat the 
  Frost Giants and seize the source of their power, the Casket of Ancient Winters.",
  small_cover_url: "/tmp/thor.jpg",large_cover_url: "/tmp/thor_large.jpg")                        
  
  Video.create(title: "Avatar", description: "When his brother is killed in a robbery, paraplegic 
  Marine Jake Sully decides to take his place in a mission on the distant world of Pandora. 
  There he learns of greedy corporate figurehead Parker Selfridge\'s intentions of driving 
  off the native humanoid \"Na\'vi\" in order to mine for the precious material scattered 
  throughout their rich woodland. In exchange for the spinal surgery that will fix his legs, 
  Jake gathers intel for the cooperating military unit spearheaded by gung-ho Colonel Quaritch, 
  while simultaneously attempting to infiltrate the Na\'vi people with the use of an \"avatar\" 
  identity.", small_cover_url: "/tmp/avatar.jpg",large_cover_url: "/tmp/avatar_large.jpg")

  Video.create(title: "Family Guy", description: "Family Guy is an American adult animated 
  sitcom created by Seth MacFarlane for the Fox Broadcasting Company. The series centers on 
  the Griffins, a family consisting of parents Peter and Lois; their children Meg, Chris, and 
  Stewie; and their anthropomorphic pet dog Brian. The show is set in the fictional city of 
  Quahog, Rhode Island, and exhibits much of its humor in the form of cutaway gags that often 
  lampoon American culture.", small_cover_url: "/tmp/family_guy.jpg",
  large_cover_url: "/tmp/family_guy_large.jpg")                        
  
  Video.create(title: "South Park", description: "South Park is an American adult animated 
    sitcom created by Trey Parker and Matt Stone for the Comedy Central television network. 
    Intended for mature audiences, the show has become famous for its crude language and dark, 
    surreal humor that satirizes a wide range of topics. The ongoing narrative revolves around 
    four boys—Stan Marsh, Kyle Broflovski, Eric Cartman, and Kenny McCormick—and their bizarre 
    adventures in and around the titular Colorado town.", small_cover_url: "/tmp/south_park.jpg",
  large_cover_url: "/tmp/south_park_large.jpg")                        
  
