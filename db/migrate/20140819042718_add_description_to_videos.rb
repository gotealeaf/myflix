class AddDescriptionToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :description, :string
  end
end
