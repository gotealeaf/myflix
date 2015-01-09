class CreateMyQueue < ActiveRecord::Migration
  def change
    create_table :my_queues do |t|
      t.integer :user_id
      t.timestamps
    end
  end
end
