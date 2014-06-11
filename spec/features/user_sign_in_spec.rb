require 'spec_helper'

feature 'user_signs_in' do
  scenario "user signs in valid email and password" do
    alice = Fabricate(:user)
    sign_in(alice)
    expect(page).to have_content alice.full_name

  end



  
end