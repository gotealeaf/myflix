# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


videos = Video.create([

        { title:'Futurama' , 
          description: 'A funny cartoon that takes place in the future' , 
          small_cover_url:'tmp/futurama.jpg',
          large_cover_url:'tmp/futurama.jpg'
          },
         
        { title:'Family Guy' , 
          description:'Hilarious animated sitcom about a truly dysfunctional family from Quahog, Rhode Island' , 
          small_cover_url:'tmp/family_guy.jpg',
          large_cover_url:'tmp/family_guy.jpg'
          },
         
        { title:'Monk' , 
          description:'An American comedy-drama detective mystery television series' , 
          small_cover_url:'tmp/monk.jpg', 
          large_cover_url:'tmp/monk_large.jpg'
          },
         
        { title:'South Park' , 
          description:'South Park is an animated series featuring four foul-mouthed 4th graders, Stan, Kyle, Kenny and Cartman.' , 
          small_cover_url:'tmp/south_park.jpg',
          large_cover_url:'tmp/south_park.jpg'
          }])