class RenameQueueToVideoQueue < ActiveRecord::Migration
  def change
    rename_table :queues, :video_queues
  end
end
