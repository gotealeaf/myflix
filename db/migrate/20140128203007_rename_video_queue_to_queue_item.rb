class RenameVideoQueueToQueueItem < ActiveRecord::Migration
  def change
    rename_table :video_queues, :queue_items
  end
end
