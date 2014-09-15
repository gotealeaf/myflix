class RenameRelationshipColumns < ActiveRecord::Migration
  def change
    rename_column :relationships, :user_id, :leader_id
    rename_column :relationships, :relationship_id, :follower_id
  end
end
