class AddUniquenessValidationOnQueueItems < ActiveRecord::Migration
  def change
    add_index :queue_items, :position, unique: true
  end
end
