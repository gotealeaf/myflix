require 'rails_helper.rb'

feature "user interacts with social networking features" do
  scenario "user follows another user" do
    joe = Fabricate(:user)
    bob = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, category: category)
    review = Fabricate(:review, user: bob, video: video, rating: 4)

    sign_in(joe)

    visit_video_via_homepage(video)
    expect_another_user_review_on_video_page(bob)

    follow
    expect_leader_on_people_page(bob)

  end

  def visit_video_via_homepage(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
  end

  def expect_another_user_review_on_video_page(another_user)
    expect(page).to have_content another_user.full_name
  end

  def follow
    click_link 'Follow'
  end

  def expect_leader_on_people_page(another_user)
    visit people_path
    expect(page).to have_content another_user.full_name
  end


end
