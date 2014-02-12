class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :password_digest
      t.timestamps
    end
  end
end
