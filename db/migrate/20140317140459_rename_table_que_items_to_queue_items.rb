class RenameTableQueItemsToQueueItems < ActiveRecord::Migration
  def change
    rename_table :que_items, :queue_items
  end
end
