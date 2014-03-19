Fabricator(:queue_item) do
  position { rand(1..10) }
  video_id { rand(1..10) }
  user_id { rand(1..10) }
end