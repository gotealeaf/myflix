Fabricator(:queue_item) do
  position {Faker::Number.digit}
  user
end
