require 'spec_helper'

feature 'user signs in' do
  scenario 'with valid email and password' do
    sign_in(mark)
    page.should have_content mark.full_name  
  end
end