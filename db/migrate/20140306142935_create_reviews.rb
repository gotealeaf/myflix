class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.text :user_review
      t.float :rating
    end
  end
end
