class CreatePasswordResets < ActiveRecord::Migration
  def change
    create_table :password_resets do |t|
      t.string :token
      t.integer :user_id
      t.timestamps
    end
  end
end
