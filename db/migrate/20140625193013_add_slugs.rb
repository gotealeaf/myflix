class AddSlugs < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_column :videos, :slug, :string
    add_column :categories, :slug, :string
  end
end
