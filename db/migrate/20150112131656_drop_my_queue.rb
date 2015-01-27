class DropMyQueue < ActiveRecord::Migration
  def change
    drop_table :my_queues
  end
end
