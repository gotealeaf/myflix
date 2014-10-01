class AddVideoIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :video_id, :integer
  end
end
