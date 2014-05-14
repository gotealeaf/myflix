class AddSmallCoverToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :small_cover, :string
  end
end
