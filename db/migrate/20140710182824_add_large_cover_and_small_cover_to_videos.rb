class AddLargeCoverAndSmallCoverToVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :large_cover
    remove_column :videos, :small_cover
    
    add_column :videos, :small_cover, :string
    add_column :videos, :large_cover, :string
  end
end
