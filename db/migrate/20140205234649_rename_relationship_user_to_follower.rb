class RenameRelationshipUserToFollower < ActiveRecord::Migration
  def change
    rename_column :relationships, :user_id, :follower_id
  end
end
