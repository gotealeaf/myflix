require "spec_helper"

feature "user_following" do
  scenario "authenticated user follows and unfollows other users" do
    maria = Fabricate(:user)
    john = Fabricate(:user)
    monk = Fabricate(:video, title: "monk")
    review = Fabricate(:review, video: monk, creator: john)

    sign_in(maria)

    visit video_path(monk)
    click_link john.fullname
    click_link "Follow"
    expect(page).to have_content john.fullname

    visit people_path
    unfollow(john)
    expect(page).to_not have_content john.fullname 
  end 

  def unfollow(user)
    find(:xpath, "//a[@data-method='delete']").click
  end
end