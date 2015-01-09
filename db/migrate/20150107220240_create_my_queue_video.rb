class CreateMyQueueVideo < ActiveRecord::Migration
  def change
    create_table :my_queue_videos do |t|
      t.integer :video_id, :my_queue_id, :index 
      t.timestamps
    end
  end
end
