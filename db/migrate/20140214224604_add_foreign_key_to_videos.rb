class AddForeignKeyToVideos < ActiveRecord::Migration
  def change
    change_table :videos do |t|
      t.references :categories, index: true
    end
  end
end
