class AddColumnTimeStampsToQues < ActiveRecord::Migration
  def change
    add_column :ques, :created_at, :datetime
    add_column :ques, :updated_at, :datetime
  end
end
