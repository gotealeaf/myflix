class ChangeRatingInReviews < ActiveRecord::Migration
  def change
    change_column :reviews, :rating, :float
  end
end
