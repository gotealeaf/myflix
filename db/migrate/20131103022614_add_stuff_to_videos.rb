class AddStuffToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :category, :string
    add_column :videos, :thumbnail, :string
  end
end
