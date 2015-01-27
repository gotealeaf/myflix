class DropVideoQueue < ActiveRecord::Migration
  def change
    drop_table :my_queue_videos
  end
end
