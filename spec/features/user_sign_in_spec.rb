require 'spec_helper'
require 'pry'

feature "signing in" do
  
  scenario "with correct email and password" do
    jane = Fabricate(:user)
    sign_in_user(jane)
    page.should have_content(jane.full_name)
  end
end