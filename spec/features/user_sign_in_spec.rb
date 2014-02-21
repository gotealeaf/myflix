require 'spec_helper'

feature "user signs in" do
	scenario "with valid email and password", js: true do
		alice = Fabricate(:user)
		sign_in(alice)
		page.should have_content alice.full_name
	end

	scenario "with deactivated user", js: true do
		alice = Fabricate(:user, active: false)
		sign_in(alice)
		expect(page).not_to have_content(alice.full_name)
		expect(page).to have_content("Your account has been suspended. Please contact customer support.")
	end
end