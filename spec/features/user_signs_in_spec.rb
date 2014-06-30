require 'rails_helper.rb'

feature "user signs in" do
  scenario "with valid email & password" do
    john = Fabricate(:user)
    sign_in(john)
    expect(page).to have_content john.full_name
  end
end
