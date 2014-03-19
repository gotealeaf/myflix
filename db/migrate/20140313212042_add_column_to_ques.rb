class AddColumnToQues < ActiveRecord::Migration
  def change
    add_column :ques, :user_id, :integer
  end
end
