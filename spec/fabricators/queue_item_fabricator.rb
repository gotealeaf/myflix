Fabricator(:queue_item) do
  video { Fabricate(:video) }
  user { Fabricate(:user) }
end