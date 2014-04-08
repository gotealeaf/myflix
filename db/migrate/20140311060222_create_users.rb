class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :fullname, :password_digest
    end
  end
end
