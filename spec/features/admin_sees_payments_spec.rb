require 'spec_helper'

feature "Admin sees payments" do
  scenario "only admin sees payments" do
    admin = Fabricate(:admin)
    
    sign_in_user(admin)
    visit admin_payments_path
  end
  scenario "ordinary users cannot see payments" do
  end
end