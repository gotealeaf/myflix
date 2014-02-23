require 'spec_helper'

feature "user signs in" do
  scenario "with valid email and password" do
  	amanda = Fabricate(:user)
  	sign_in(amanda)
  	page.should have_content amanda.full_name
  end
end