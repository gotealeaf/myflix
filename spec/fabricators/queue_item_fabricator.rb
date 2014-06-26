Fabricator(:queue_item) do
  user { Fabricate(:user) }
  video { Fabricate(:video) }
  position 1
end
