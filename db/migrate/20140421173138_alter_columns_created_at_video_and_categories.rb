class AlterColumnsCreatedAtVideoAndCategories < ActiveRecord::Migration
  def change
    change_column :categories, :created_at, :timestamp
    change_column :videos, :created_at, :timestamp
  end
end
