require 'spec_helper'

feature "Admin sees payments" do
	background do
		alice = Fabricate(:user, full_name: "Alice Doe", email: "alice@example.com")
		Fabricate(:payment, amount: 999, user: alice)
	end

	scenario "Admin can see the Payments", js: true do
		sign_in(Fabricate(:admin))
		visit admin_payments_path
		expect(page).to have_content("$9.99")
		expect(page).to have_content("Alice Doe")
		expect(page).to have_content("alice@example.com")
	end

	scenario "User cannot see payments", js: true do
		sign_in(Fabricate(:user))
		visit admin_payments_path
		expect(page).not_to have_content("$9.99")
		expect(page).not_to have_content("Alice Doe")
		expect(page).to have_content("You are not authorized to do that.")
	end
end