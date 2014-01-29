class AddVideoUrlToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :video_url, :string
  end
end
