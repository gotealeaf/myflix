class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :rating
      t.text :review_description
      t.integer :video_id

      t.timestamps
    end
  end
end
