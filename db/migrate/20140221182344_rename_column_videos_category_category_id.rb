class RenameColumnVideosCategoryCategoryId < ActiveRecord::Migration
  def change
  	rename_column :videos, :category, :category_id
  end
end
