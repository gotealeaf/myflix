class DropVideoCategories < ActiveRecord::Migration
  def change
    drop_table :video_categories
  end
end
