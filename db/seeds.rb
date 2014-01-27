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
scifi = Category.create(name:'Scifi')
