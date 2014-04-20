Fabricator(:relationship) do
  user_id { rand(1..10) }
  follower_id { rand(1..10) }
end