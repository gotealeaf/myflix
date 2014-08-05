require "spec_helper"

feature "invite a friend to join" do
  scenario "user sends an invite to a friend and the friend registers" do
    sam = Fabricate(:user)
    sign_in(sam)
    
    send_out_invitation
    friend_accepts_invitation

    friend_should_follow(sam)
    inviter_should_follow_invitee(sam)

    clear_email
  end 

  def send_out_invitation
    visit invite_path
    fill_in "Friend's Name", with: "Sally Anderson"
    fill_in "Friend's Email", with: "sally@test.com"
    fill_in "Invitation Message", with: "Please join!"
    click_button "Send Invitation"
  end

  def friend_accepts_invitation
    open_email("sally@test.com")
    current_email.click_link "Accept Invitation"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Sally Anderson"
    click_button "Sign Up"
  end

  def friend_should_follow(user)
    visit people_path
    expect(page).to have_content user.fullname
    sign_out
  end

  def inviter_should_follow_invitee(inviter)
    sign_in(inviter)
    visit people_path
    expect(page).to have_content "Sally Anderson"
  end
end