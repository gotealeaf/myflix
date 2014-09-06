Fabricator(:video) do
  #title {'Monk'}
  title {Faker::Lorem.word}
  #description {"clever TV show"}
  description {Faker::Lorem.words(10).join(" ")}
  category
end
