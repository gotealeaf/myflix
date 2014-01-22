class AddVideoCategories < ActiveRecord::Migration
  def change
 add_column :videos, :video_category, :string
  end
end
