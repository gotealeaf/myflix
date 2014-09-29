class AddCategoryToVideo < ActiveRecord::Migration
  def change
    change_table :videos do |t|
     t.integer :category_id
    end
  end
end
