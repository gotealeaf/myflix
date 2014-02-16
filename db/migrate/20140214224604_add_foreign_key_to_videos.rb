class AddForeignKeyToVideos < ActiveRecord::Migration
  def change
    change_table :videos do |t|
      t.belongs_to :category, index: true
    end
  end
end
