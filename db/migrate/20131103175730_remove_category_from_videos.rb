class RemoveCategoryFromVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :category, :string
  end
end