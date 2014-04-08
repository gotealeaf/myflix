class AddSmallCoverToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :small_cover, :string
    remove_column :videos, :samll_cover
  end
end
