class ChangeRelationshipsLeaderColumnToLeaderIdFromUserId < ActiveRecord::Migration
  def self.up
    rename_column :relationships, :user_id, :leader_id
  end
end
