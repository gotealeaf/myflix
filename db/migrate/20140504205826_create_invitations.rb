class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :user
      t.string :invitee_email
      t.timestamps
    end
  end
end
