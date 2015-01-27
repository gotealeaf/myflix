class CreateReviews< ActiveRecord::Migration
  def change

    create_table :reviews do |t|
      t.string :user_id
      t.string :video_id
      t.string :body
      t.integer :rating 
      t.timestamps 
    end
  end
end
