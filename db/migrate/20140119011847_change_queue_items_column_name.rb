class ChangeQueueItemsColumnName < ActiveRecord::Migration
  def change
    rename_column :queue_items, :positon, :position
  end
end
