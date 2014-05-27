class FixUrlColumnNamesInVideos < ActiveRecord::Migration
  def change
    rename_column :videos, :smallimageurl, :small_cover_url
    rename_column :videos, :largeimageurl, :large_cover_url

  end
end
