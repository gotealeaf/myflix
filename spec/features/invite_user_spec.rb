require 'spec_helper'

feature "user invites a friend" do
  scenario "a user invites a friend who is not registered" do
    billy = sign_in

    click_link 'People'
    click_link 'Invite by email'

    fill_in_invite_form_and_submit('John Doe', 'john@example.com')

    click_link 'Sign Out'

    open_email_and_click_link('john@example.com', 'Register Now!')

    fill_in_register_form_and_submit('john@example.com', 'secret_password', 'John Doe')

    open_email_and_click_link('john@example.com', 'Click here to log in.')

    sign_in(User.find_by_email('john@example.com'), 'secret_password')

    click_link 'People'

    expect(page).to have_content billy.full_name

    click_link 'Sign Out'

    sign_in(billy)

    click_link 'People'

    expect(page).to have_content 'John Doe'
  end

  private

  def fill_in_invite_form_and_submit(name, email)
    fill_in "Friend's Name", with: name
    fill_in "Friend's Email Address", with: email
    click_button 'Send Invitation'
  end

  def fill_in_register_form_and_submit(email, password, name)
    fill_in 'Email Address', with: email
    fill_in 'Password', with: password
    fill_in 'Confirm Password', with: password
    fill_in 'Full Name', with: name
    click_button 'Sign Up'
  end
end