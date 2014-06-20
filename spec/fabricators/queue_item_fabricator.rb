Fabricator(:queue_item) do
  position Fabricate.sequence(:number, 1)
end