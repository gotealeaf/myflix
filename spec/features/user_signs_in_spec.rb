require 'spec_helper'

feature 'User signs in' do
  scenario "with valid email and password" do
    darren = Fabricate(:user)
    sign_in(darren)
    page.should have_content darren.full_name
  end
end