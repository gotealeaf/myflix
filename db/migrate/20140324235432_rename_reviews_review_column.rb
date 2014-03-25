class RenameReviewsReviewColumn < ActiveRecord::Migration
  def change
    rename_column :reviews, :review, :text
  end
end
