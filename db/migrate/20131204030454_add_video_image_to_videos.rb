class AddVideoImageToVideos < ActiveRecord::Migration
  def change
   add_column :videos, :cover_image_url, :string
  end
end
