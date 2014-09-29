class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string  :recipient_name
      t.string  :recipient_email
      t.text    :message
      t.integer :inviter_id
      t.timestamps
    end
  end
end
