require 'spec_helper'

feature "User signs in" do 
  
  scenario "with valid email and password" do
    karen = Fabricate(:user)
    sign_in(karen)
    page.should have_content karen.full_name
  end
end