require "rails_helper"

feature "Following user" do
  scenario "User follows and unfollows another user" do
    alice = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, category: category)
    Fabricate(:review, user: alice, video: video)

    sign_in
    click_video_on_home_page(video)
    click_link alice.name
    click_link "Follow"

    expect(page).to have_content(alice.name)

    unfollow(alice)

    expect(page).not_to have_content(alice.name)
  end


  def unfollow(a_user)
    find("a[data-method='delete']").click
  end
end