class CreateQueueItems < ActiveRecord::Migration
  def change
    create_table :queue_items do |t|
      t.belongs_to :user
      t.belongs_to :video
      t.integer :position

      t.timestamps
    end
  end
end
