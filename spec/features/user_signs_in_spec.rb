require 'spec_helper'

feature 'User signs in' do
  scenario "with existing username" do
    sam = Fabricate(:user)
    sign_in(sam)
    page.should have_content sam.full_name
  end
end
