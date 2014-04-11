Fabricator(:video) do
  title Faker::Name.name
  description Faker::Name.name
  big_cover_url "/tmp/monk_large.jpg"
  small_cover_url { "/tmp/" + ["family_guy","futurama","monk","south_park"].sample + ".jpg"} 
end

Fabricator(:category) do
  name Faker::Name.name
end
