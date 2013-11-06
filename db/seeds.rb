# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.find(1).categories << Category.find(1)
Video.find(2).categories << Category.find(2)
Video.find(3).categories << Category.find(1)
Video.find(3).categories << Category.find(1)



