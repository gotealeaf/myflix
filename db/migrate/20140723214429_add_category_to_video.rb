class AddCategoryToVideo < ActiveRecord::Migration
  def change
    change_table :videos do |t|
     t.string :category
    end
  end
end
