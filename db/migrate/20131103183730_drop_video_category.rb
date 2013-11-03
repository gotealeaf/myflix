class DropVideoCategory < ActiveRecord::Migration
  def up
     drop_table :video_categories
   end

   def down
     raise ActiveRecord::IrreversibleMigration
   end
end
