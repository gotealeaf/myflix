class CreateQueueItems < ActiveRecord::Migration
  def change
    create_table :queue_items do |t|
      t.integer :video_id
      t.integer :user_id
      t.integer :position
      t.timestamps
    end
  end
end
