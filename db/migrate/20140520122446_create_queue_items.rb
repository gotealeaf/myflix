class CreateQueueItems < ActiveRecord::Migration
  def change
    create_table :queue_items do |t|
      t.references :user, index: true
      t.references :video, index: true
      t.integer :position

      t.timestamps
    end
  end
end
