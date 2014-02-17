require "spec_helper"

feature "test invite a friend functionality" do

  scenario "invite a friend" do
    joe = new_logged_in_user
    invite_friend
    verify_invitation_page
    sign_out
    process_email
    register_new_user
    visit_people_page(joe.full_name)
    sign_out
    sign_in(joe)
    visit_people_page("Alice Humperdink")
  end

  private

  def new_logged_in_user
    user = Fabricate(:user)
    sign_in(user)
    user
  end

  def invite_friend
    click_link "Invite a Friend"
    fill_in "Friend's Name", with: "Alice Humperdink"
    fill_in "Friend's Email Address", with: "alice@example.com"
    fill_in "Invitation Message", with: "Please join!"
    click_button "Send Invitation"
  end

  def verify_invitation_page
    expect(page).to have_content "Alice Humperdink has been invited to be your friend!"
  end

  def process_email
    open_email("alice@example.com")
    current_email.click_link("Sign Me Up!")
  end

  def register_new_user
    expect(page).to have_content "Register"
    fill_in "Password", with: "alice"
    click_button "Sign Up"
    expect(page).to have_content "Welcome, Alice Humperdink"
  end

  def visit_people_page(content)
    click_link "People"
    expect(page).to have_content content
  end
end