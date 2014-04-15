Fabricator(:queue_item) do
  position { QueueItem.count + 1 }
end


Fabricator(:queue_item_no_review, from: :queue_item) do
  user
  video
  position { QueueItem.count + 1 }
end
