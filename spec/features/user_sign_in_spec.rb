require 'spec_helper'

feature "user_sign_in" do
  scenario "user enters email and password" do
    alice = Fabricate(:user)
    sign_in(alice)
    page.should have_content alice.full_name
  end
end