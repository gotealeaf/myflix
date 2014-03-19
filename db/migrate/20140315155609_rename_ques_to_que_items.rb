class RenameQuesToQueItems < ActiveRecord::Migration
  def change
    rename_table :ques, :que_items
  end
end
