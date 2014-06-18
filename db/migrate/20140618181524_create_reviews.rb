class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :video
      t.belongs_to :user
      t.integer :rating
      t.text :content

      t.timestamps
    end
  end
end
