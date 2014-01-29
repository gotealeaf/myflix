class AddPositionToQueueItems < ActiveRecord::Migration
  def change
    add_column :queue_items, :position, :integer
  end
end
