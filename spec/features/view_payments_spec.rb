require "spec_helper"

feature "view payments" do

  background do
    alice = Fabricate(:user, full_name: "Alice Humperdink", email: "alice@example.com")
    payment = Fabricate(:payment, amount: 999, user: alice, reference: "abcde")
  end

  scenario "admin can see payments" do
    user = sign_in(nil, :admin)
    click_on "Welcome, #{user.full_name}"
    click_link "Recent Payments"
    expect(page).to have_content("Alice Humperdink")
    expect(page).to have_content("$9.99")
    expect(page).to have_content("alice@example.com")
    expect(page).to have_content("abcde")
  end

  scenario "regular users cannot see payments" do
    sign_in
    visit admin_payments_path
    expect(page).not_to have_content("Alice Humperdink")
    expect(page).not_to have_content("$9.99")
    expect(page).not_to have_content("alice@example.com")
    expect(page).not_to have_content("abcde")
    expect(page).to have_content("You are not authorized to do that.")
  end

end