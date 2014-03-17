class RenameColumnReviewsUserReviewToContent < ActiveRecord::Migration
  def change
    rename_column :reviews, :user_review, :content
  end
end
