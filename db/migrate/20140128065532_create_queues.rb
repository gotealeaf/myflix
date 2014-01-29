class CreateQueues < ActiveRecord::Migration
  def change
    create_table :queues do |t|
      t.references :user
      t.references :video
      t.integer :rating
      t.timestamps
    end
  end
end
