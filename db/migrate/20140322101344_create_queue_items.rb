class CreateQueueItems < ActiveRecord::Migration
  def change
    create_table :queue_items do |t|
      t.integer :user_id, :video_id
      t.integer :order
      t.timestamps :created_at
    end
  end
end

