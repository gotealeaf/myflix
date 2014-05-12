class CreateStripeWrappers < ActiveRecord::Migration
  def change
    create_table :stripe_wrappers do |t|

      t.timestamps
    end
  end
end
