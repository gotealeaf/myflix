class AddImagesToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :small_thumb, :string
    add_column :videos, :large_thumb, :string
  end
end
