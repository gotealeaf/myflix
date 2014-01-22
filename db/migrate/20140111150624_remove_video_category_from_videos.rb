class RemoveVideoCategoryFromVideos < ActiveRecord::Migration
  def change
   remove_column :videos, :video_category, :string
  end
end
