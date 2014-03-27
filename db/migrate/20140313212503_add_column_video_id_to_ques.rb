class AddColumnVideoIdToQues < ActiveRecord::Migration
  def change
    add_column :ques, :video_id, :integer
  end
end
