# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


####################################VIDEOS SEED#################################
# Setup Videos From JPG's
file_urls = Dir.glob("public/tmp/*.jpg").each{|e| e.gsub!("public", "")}
small_covers = []
large_covers = []
file_urls.each do |url|
  url.scan(/(_large)/).empty? ? small_covers.push(url) : large_covers.push(url)
end

# Setup Categories in db
["Cartoon", "Drama", "Comedy"].each do |cat|
  Category.create(name: cat)
end

#Setup Hash Lookup
vid_categories = {family_guy: [3, 1],
                futurama: [3, 1],
                initialD: [1],
                lie_to_me: [2],
                monk: [2],
                south_park: [3, 1]}

18.times do
  sm_cover = small_covers.sample
  filename = File.basename(sm_cover, ".jpg")
  title = filename.gsub("_", " ")
  vid_catids = vid_categories[filename.to_sym]
  description = "This is the commercial-free full-length episode of #{title}."
  lg_cover = ""
  large_covers.each do |file|
    file.include?(filename) ? lg_cover=file.to_s : next
  end
  (lg_cover = sm_cover) if lg_cover.empty?

  Video.create(title: title,
               description: description,
               sm_cover_locn: sm_cover,
               lg_cover_locn: lg_cover,
               category_ids: vid_catids )
end


#################################USERS SEED###################################
20.times do
  user_name = Faker::Name.name
  user_email = Faker::Internet.safe_email
  User.create(name: user_name, email: user_email, password: "password")
end


#################################REVIEWS SEED###################################
#Each user makes a review on a video
User.all.limit(5).each do |u|
  Video.all.each do |vid|
    vid_rating = [1,2,3,4,5].sample.to_f
    vid_content = Faker::Lorem.paragraph
    vid.reviews.create(rating: vid_rating, content: vid_content, user_id: u.id)
  end
end

