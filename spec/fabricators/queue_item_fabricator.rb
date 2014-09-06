Fabricator(:queue_item) do
  !position {Faker::Number.digit}
  position 1
  user
  video
end
