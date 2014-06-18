class AddTimestampsToPayments < ActiveRecord::Migration
  def change
    add_timestamps :payments
  end
end
