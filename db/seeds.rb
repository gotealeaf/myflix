# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(name: "Community", description: "A funny show about people going to a community college.", small_thumb: "community_sm", large_thumb: "community_lg")
Video.create(name: "Sherlock", description: "A detective uses his smarts to outsmart smart criminals. Plus he's British!", small_thumb: "sherlock_sm", large_thumb: "sherlock_lg")