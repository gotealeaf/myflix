class AlterColumnsCreatedAtVideoAndCategories < ActiveRecord::Migration
  def change
    change_column :categories, :created_at, :timestamps
    change_column :videos, :created_at, :timestamps
  end
end
