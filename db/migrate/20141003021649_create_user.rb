class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :email
    	t.string :password_digest
    	t.string :fullname
    	t.timestamps
    end
  end
end
