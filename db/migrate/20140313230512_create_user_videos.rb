class CreateUserVideos < ActiveRecord::Migration
  def change
    create_table :user_videos do |t|
      t.integer :user_id, :video_id
    end
  end
end
