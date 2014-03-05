class RenameLargeCoverToVideos < ActiveRecord::Migration
  def change
  	rename_column :videos, :big_cover, :large_cover
  end
end
