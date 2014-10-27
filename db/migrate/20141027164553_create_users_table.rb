class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :full_name
      t.string :avatar_url
      t.timestamps
    end
  end
end
