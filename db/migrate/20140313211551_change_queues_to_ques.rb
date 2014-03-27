class ChangeQueuesToQues < ActiveRecord::Migration
  def change
    rename_table :queues, :ques
  end
end
