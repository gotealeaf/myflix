Fabricator :relationship do 
  user_id { (1..100).to_a.sample }
  follower_id { (1..100).to_a.sample }
end