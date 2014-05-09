class AddLargeCoverToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :large_cover, :string
  end
end
