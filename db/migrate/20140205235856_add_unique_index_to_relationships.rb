class AddUniqueIndexToRelationships < ActiveRecord::Migration
  def change
    add_index :relationships, [:leader_id, :follower_id], unique: true
  end
end
