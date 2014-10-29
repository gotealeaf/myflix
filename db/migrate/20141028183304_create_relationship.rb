class CreateRelationship < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :following_id
      t.timestamps
    end
  end
end
