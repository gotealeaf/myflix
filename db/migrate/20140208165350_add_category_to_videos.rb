class AddCategoryToVideos < ActiveRecord::Migration
  def change
  	add_column :videos, :category, :integer
  end
end
