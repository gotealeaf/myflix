class AddLargeCoverSmallCoverToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :large_cover, :string
    add_column :videos, :small_cover, :string
    remove_column :videos, :url
    remove_column :videos, :url_large
  end
end
