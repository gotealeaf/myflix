Fabricator(:video) do
  title { "#{Faker::Lorem.words(2).join(" ")}" }
  description { "#{Faker::Lorem.words(5).join(" ")}" }
  small_cover { "/tmp/monk.jpg" }
end

