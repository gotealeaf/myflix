class AddTimestampsToVideo < ActiveRecord::Migration
  def change
   change_table :videos do |t| 
   t.timestamps 
  end 
  end
end
