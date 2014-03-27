class CreateQueue < ActiveRecord::Migration
  def change
    create_table :myqueues do |t|
      t.integer :user_id
      t.integer :video_id
      t.integer :order
      t.integer :rating
      t.timestamps :created_at
    end
  end
end
