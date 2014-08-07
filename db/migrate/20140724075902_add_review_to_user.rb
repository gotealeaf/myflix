class AddReviewToUser < ActiveRecord::Migration
  def change
    add_column :users, :review_id, :integer
  end
end
