class ChangeRelationshipColumnName < ActiveRecord::Migration
  def self.up
    rename_column :relationships, :leader_id, :user_id
  end

  def self.down
  end
end
