class ChangeColumnNameInCategory < ActiveRecord::Migration
  def change
    change_table :categories do |t|
      t.rename :category, :name
    end
  end
end
