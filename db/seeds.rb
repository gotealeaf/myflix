# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: "Furious 6", small_cover_url: "S_fast_furious6.jpg", large_cover_url: "L_fast_furious6.jpg",
  description: "Hobbs has Dom and Brian reassemble their crew in order to take down a mastermind who commands an organization of mercenary drivers across 12 countries. Payment? Full pardons for them all.")

Video.create(title: "Mission: Impossible - Ghost Protocol", small_cover_url: "S_mig.jpg", large_cover_url: "L_mig.jpg",
  description: "The IMF is shut down when it's implicated in the bombing of the Kremlin, causing Ethan Hunt and his new team to go rogue to clear their organization's name.")

Video.create(title: "Tokoy drift", small_cover_url: "S_ff.jpg", large_cover_url: "S_ff.jpg",
  description: "The Fast and the Furious: Tokyo Drift is a 2006 American street racing action film directed by Justin Lin, produced by Neal H. Moritz, and written by Chris Morgan.")

Video.create(title: "futurama", small_cover_url: "futurama.jpg", large_cover_url: "futurama.jpg",
  description: "Futurama is set in New New York at the turn of the 31st century, in a time filled with technological wonders.")

 Video.create(title: "south park", small_cover_url: "south_park.jpg", large_cover_url: "south_park.jpg",
  description: "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone for the Comedy Central television network.")

  Video.create(title: "family guy", small_cover_url: "family_guy.jpg", large_cover_url: "family_guy.jpg",
  description: "Family Guy is an American adult animated sitcom created by Seth MacFarlane for the Fox Broadcasting Company.")