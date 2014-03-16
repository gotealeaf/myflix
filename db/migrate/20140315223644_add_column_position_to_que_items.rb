class AddColumnPositionToQueItems < ActiveRecord::Migration
  def change
    add_column :que_items, :position, :integer
  end
end
