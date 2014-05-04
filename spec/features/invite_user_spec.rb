require 'spec_helper'

feature "user invites a friend" do
  let(:billy) { Fabricate(:user) }
  let(:john) { Fabricate.attributes_for(:user) }

  scenario "a user invites a friend who signs up" do
    sign_in(billy)
    click_link 'People'
    click_link 'Invite by email'

    fill_in "Friend's Name", with: 'John Doe'
    fill_in "Friend's Email Address", with: 'john@example.com'
    click_button 'Send Invitation'
  end
end