class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :content
      t.references :user, index: true
      t.references :video, index: true

      t.timestamps
    end
  end
end
