class RemoveUniquenessValidationOnQueueItems < ActiveRecord::Migration
  def change
    remove_index :queue_items, :position
  end
end
