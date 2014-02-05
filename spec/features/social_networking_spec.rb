require 'spec_helper'

feature 'Social networking' do
  given(:adam) { Fabricate(:user) }
  given(:bryan) { Fabricate(:user) }
  given(:video) { Fabricate(:video) }

  before do
    Fabricate(:review, video: video, creator: bryan)
  end

  scenario 'a user can follow a reviewer and then unfollow them' do
    sign_in(adam)
    navigate_to_video(video)
    view_reviewers_profile(bryan)
    navigate_to_people_page
    expect_to_see_leader(bryan)
    unfollow(bryan)
    expect_not_to_see_leader(bryan)
  end
end

def navigate_to_video(video_to_view)
  click_on 'Videos'
  find(:xpath, "//a[@href='#{video_path(video_to_view)}']").click
end

def view_reviewers_profile(reviewer)
  click_on reviewer.full_name
end

def navigate_to_people_page
  click_on 'Follow'
  click_on 'People'
end

def expect_to_see_leader(leader)
  expect(page).to have_content(leader.full_name)
end

def expect_not_to_see_leader(leader)
  expect(page.has_xpath?("//tr[contains(.,'#{leader.full_name}')]//a[@data-method='delete']")).to eq(false)
end

def unfollow(leader)
  find(:xpath, "//tr[contains(.,'#{leader.full_name}')]//a[@data-method='delete']").click
end
