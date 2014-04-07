require 'spec_helper'

feature "User invites friend", { js: true, vcr: true } do
  scenario "User successfully invites a freiend and invitation is accepted" do
    desmond = Fabricate(:user)
    sign_in(desmond)

    invite_a_friend
    friend_accepts_invitation
    friend_signs_in

    friend_should_follow(desmond)
    inviter_should_follow_friend(desmond)

    clear_email
  end

  def invite_a_friend
    visit new_invitation_path
    fill_in "Friend's Name", with: "Linda"
    fill_in "Friend's Email Address", with: "linda@123.com"
    fill_in "Invitation Message", with: "Hey Linda"
    click_button "Send Invitation"
    sign_out
  end

  def friend_accepts_invitation
    open_email("linda@123.com")
    current_email.click_link "Accept this invitation"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Linda"
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "4 - April", from: 'date_month'
    select "2016", from: 'date_year'
    click_button "Sign Up"
  end

  def friend_signs_in
    fill_in "Email Address", with: "linda@123.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
  end

  def friend_should_follow(user)
    click_link "People"
    expect(page).to have_content user.fullname
    sign_out
  end

  def inviter_should_follow_friend(user)
    sign_in(user)
    click_link "People"
    expect(page).to have_content "Linda"
  end
end
