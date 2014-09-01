class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id, :amount
      t.string :reference_id
    end
  end
end
