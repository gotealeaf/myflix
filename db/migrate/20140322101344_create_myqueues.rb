class CreateMyqueues < ActiveRecord::Migration
  def change
    create_table :my_queues do |t|
      t.integer :user_id
      t.integer :video_id
      t.integer :order
      t.integer :rating
      t.timestamps :created_at
    end
  end
end

