class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :inviter_email
      t.string :guest_email
      t.timestamps
    end
  end
end
