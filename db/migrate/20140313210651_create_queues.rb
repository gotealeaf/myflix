class CreateQueues < ActiveRecord::Migration
  def change
    create_table :queues do |t|
      t.integer :list_order
      t.string :video_title
      t.string :genre
    end
  end
end
