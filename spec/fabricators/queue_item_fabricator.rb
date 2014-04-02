Fabricator(:queue_item) do
  position { "#{[1..10].sample}" }
end
