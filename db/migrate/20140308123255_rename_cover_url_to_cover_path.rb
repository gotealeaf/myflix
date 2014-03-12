class RenameCoverUrlToCoverPath < ActiveRecord::Migration
  def change
    rename_column :videos, :small_cover_url, :small_cover_path
    rename_column :videos, :large_cover_url, :large_cover_path
  end
end
