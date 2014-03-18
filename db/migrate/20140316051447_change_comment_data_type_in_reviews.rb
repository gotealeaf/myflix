class ChangeCommentDataTypeInReviews < ActiveRecord::Migration
  def up
    change_column :reviews, :comment, :text
  end
  def down
    change_column :reviews, :comment, :string
  end


end
