require 'spec_helper'

feature 'User signs in' do 
  scenario "with existing user" do
    john_doe = Fabricate(:user, full_name: "John Doe")
    user_signs_in(john_doe)
    expect(page).to have_content("John Doe")
  end
end