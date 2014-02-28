require "spec_helper"

feature "test invite a friend functionality" do

  scenario "user successfully invites a friend, and invitation is accepted", { js: true, vcr: true } do
    joe = new_logged_in_user
    invite_friend
    friend_accepts_invitation
    visit_people_page(joe.full_name)
    sign_out
    sign_in(joe)
    visit_people_page("Alice Humperdink")
    clear_email
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
    expect(page).to have_content "Alice Humperdink has been invited to be your friend!"
    sign_out
  end

  def friend_accepts_invitation
    open_email("alice@example.com")
    current_email.click_link("Sign Me Up!")
    expect(page).to have_content "Register"
    fill_in "Password", with: "alice"
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "3 - March", from: "date_month"
    select "2016", from: "date_year"

    click_button "Sign Up"
    expect(page).to have_content "Welcome, Alice Humperdink"
  end

  def visit_people_page(content)
    click_link "People"
    expect(page).to have_content content
  end
end