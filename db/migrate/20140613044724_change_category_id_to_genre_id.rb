class ChangeCategoryIdToGenreId < ActiveRecord::Migration
  def change
    rename_column :videos, :category_id, :genre_id
  end
end
