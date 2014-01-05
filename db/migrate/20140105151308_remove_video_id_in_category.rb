class RemoveVideoIdInCategory < ActiveRecord::Migration
  def up
    remove_column :categories, :video_id
  end

  def down
    add_column :categories, :video_id, :integer
  end
end
