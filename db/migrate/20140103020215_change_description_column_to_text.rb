class ChangeDescriptionColumnToText < ActiveRecord::Migration
  def self.up
    change_column :videos, :description, :text, limit: nil
  end

  def self.down
    change_column :videos, :description, :string
  end

end
