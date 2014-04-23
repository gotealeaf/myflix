class AddTableInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.string :fullname, :email, :status
      t.text :message
      t.timestamps
    end
  end
end
