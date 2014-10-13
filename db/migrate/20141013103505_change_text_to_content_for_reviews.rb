class ChangeTextToContentForReviews < ActiveRecord::Migration
  def change
    rename_column :reviews, :text, :content
  end
end
