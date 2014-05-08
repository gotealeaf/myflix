class RemoveCoverUrlColumnsFromVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :large_cover_url
    remove_column :videos, :small_cover_url
  end
end
