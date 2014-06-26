Fabricator(:queue_item) do
  user { Fabricate(:user) }
  video { Fabricate(:video) }
  position { (0..5).to_a.sample }
end
