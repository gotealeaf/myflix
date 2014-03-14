class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :video_id
      t.text :content
      t.integer :rating
      t.timestamps
    end
  end
end
