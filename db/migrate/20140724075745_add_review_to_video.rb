class AddReviewToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :review_id, :integer
  end
end
