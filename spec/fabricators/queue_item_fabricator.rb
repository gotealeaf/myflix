Fabricator :queue_item do 
  user_id { (1..100).to_a.sample }
  video_id { (1..100).to_a.sample }
  order {  (1..10).to_a.sample }  
end