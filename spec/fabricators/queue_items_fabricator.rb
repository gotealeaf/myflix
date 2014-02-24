Fabricator(:queue_item) do
  position { (1...5).to_a.sample }
  video_id { Fabricate(:video).id }
  user_id { Fabricate(:user).id }
end
