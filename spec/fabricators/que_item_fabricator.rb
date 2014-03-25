Fabricator(:queue_item) do
  user { Fabricate(:user) }
  video { Fabricate(:video) }
  position{ rand(1..10) }
end