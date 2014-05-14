class SetCurrentUserAdminStatusToFalse < ActiveRecord::Migration
  def change
    User.all.each do |user|
      user.update_column(:admin, false)
    end
  end
end
