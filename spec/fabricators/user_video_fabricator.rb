Fabricator(:user_video) do
  user_id { rand(1..10) }
  video_id { rand(1..10) }
end