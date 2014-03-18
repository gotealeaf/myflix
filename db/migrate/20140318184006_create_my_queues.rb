class CreateMyQueues < ActiveRecord::Migration
  def change
    create_table :my_queues do |t|
      t.integer :list_num
      t.integer :video_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
