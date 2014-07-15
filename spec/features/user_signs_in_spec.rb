require "spec_helper"

feature 'User signs in' do
  scenario "with existing email" do
    lalaine = Fabricate(:user)
    sign_in(lalaine)
    expect(page).to have_content lalaine.username
  end
end