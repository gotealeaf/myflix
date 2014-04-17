require 'pry'
require 'spec_helper'

feature 'invitation sending and accepting' do
  given(:adam) { Fabricate(:user) }
  scenario 'login as user, invite other user, accept invitation' do
    sign_in(adam)

    visit new_invitation_path

    expect(page).to have_content "Invite User to Myflix"

    message = Faker::Lorem.paragraphs(2).join('')
    email = Faker::Internet.email

    fill_in 'Email', :with => email
    fill_in 'Fullname', :with => Faker::Name.first_name
    fill_in 'Message', :with => message

    click_button 'Invite User'

    expect(page).to have_content 'Your invitation has been successfully sent.'

    visit logout_path

    open_email(email)

    current_email.click_link 'here'
    expect(page).to have_content 'Register'

    fill_in 'Password', :with => "testing"

    click_button 'Submit'

    expect(page).to have_content 'You are now successfully'

    visit logout_path

    visit login_path
    fill_in "Email", :with => email
    fill_in "Password", :with => "testing"
    click_button "Submit"

    visit people_path

    expect(page).to have_content adam.fullname

  end

  def sign_in(user)
    visit login_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Submit"
  end
end
