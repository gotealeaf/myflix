Fabricator(:relationship) do
  leader_id { rand(1..10) }
  follower_id { rand(1..10) }
end