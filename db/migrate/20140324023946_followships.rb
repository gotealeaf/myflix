class Followships < ActiveRecord::Migration
  def change
    create_table :followships do |t|
      t.integer :user_id, :follower_id
      t.timestamps
    end
  end
end
