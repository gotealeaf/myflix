class AddColumnToVideos < ActiveRecord::Migration
  def change
    add_column :Videos, :rating, :integer
  end
end
