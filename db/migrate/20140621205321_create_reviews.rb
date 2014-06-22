class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :user_id, :video_id, :rating

      t.timestamps
    end
  end
end
