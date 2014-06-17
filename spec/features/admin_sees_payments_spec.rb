require 'spec_helper'

feature "Admin sees payments" do
  
  background do
    foo = Fabricate(:user, email: "foo@example.com", full_name: "Foo Foo")
    Fabricate(:payment, amount: 999, user: foo)
  end
  
  scenario "only admin sees payments" do
    admin = Fabricate(:admin)
    sign_in_user(admin)
    visit admin_payments_path
    expect(page).to have_content("$9.99")
    expect(page).to have_content("Foo Foo")
    expect(page).to have_content("foo@example.com")
  end
  
  scenario "ordinary users cannot see payments" do 
    sign_in_user(Fabricate(:user, full_name: "Boo", email: "boo@example.com"))
    visit admin_payments_path
    expect(page).not_to have_content("$9.99")
    expect(page).not_to have_content("Foo Foo")
    expect(page).not_to have_content("foo@example.com")
    expect(page).to have_content("You do not have permission to access that area.")
  end
end