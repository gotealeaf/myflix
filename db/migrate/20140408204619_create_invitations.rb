class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :inviter_id
      t.string  :friend_name
      t.string  :friend_email
      t.text    :message
      t.string  :token
    end
  end
end
