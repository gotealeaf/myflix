class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :user_id
      t.integer :video_id
      t.integer :rating
      t.timestamps
    end
  end
end
