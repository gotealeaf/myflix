class RenameDescriptionColumnInReviews < ActiveRecord::Migration
  def change
    rename_column :reviews, :description, :comment
  end
end
