class AddTokenToEachUser < ActiveRecord::Migration
  def change
    User.all.each do |usr|
      usr.update_columns(token: usr.generate_token)
    end
  end
end
