class CreateVideoRatings < ActiveRecord::Migration
  def change
    create_table :video_ratings do |t|
      t.integer :user_id
      t.integer :review_id
      t.timestamp
    end
  end
end
