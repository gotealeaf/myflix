class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps
      t.string :name
      t.string :password_digest
    end
  end
end
