class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :friend_name
      t.string :friend_email
      t.integer :user_id
      t.timestamps
    end
  end
end
