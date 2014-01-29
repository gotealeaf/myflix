Fabricator(:queue_item) do
  video { Fabricate(:video) }
  user { Fabricate(:user) }
  position { [1..5].sample }
end
