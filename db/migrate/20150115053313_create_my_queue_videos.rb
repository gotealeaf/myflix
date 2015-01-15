class CreateMyQueueVideos < ActiveRecord::Migration
  def change
    create_table :my_queue_videos do |t|
      t.integer  :user_id, :video_id, :index
      t.timestamps
    end
  end
end
