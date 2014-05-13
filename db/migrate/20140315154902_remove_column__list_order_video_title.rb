class RemoveColumnListOrderVideoTitle < ActiveRecord::Migration
  def change
    remove_column :ques, :list_order
    remove_column :ques, :video_title
    remove_column :ques, :genre
  end
end
