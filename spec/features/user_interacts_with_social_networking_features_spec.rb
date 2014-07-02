require 'rails_helper.rb'

feature "user interacts with social networking features" do
  scenario "user follows another user" do
    bob = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, category: category)
    review = Fabricate(:review, user: bob, video: video, rating: 4)

    sign_in
    click_on_video_on_home_page(video)

    click_link bob.full_name
    click_link "Follow"
    expect(page).to have_content(bob.full_name)

    unfollow(bob)
    expect(page).not_to have_content(bob.full_name)

  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end
end
