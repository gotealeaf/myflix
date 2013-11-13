class RenameQueueItem < ActiveRecord::Migration
  def self.up
    rename_table :queue_item, :queue_items
  end

  def self.down
    rename_table :queue_items, :queue_item
  end
end
