require 'spec_helper'

feature "User following" do 
  scenario "user follows a person and then unfollows them" do
    alice = Fabricate(:user)
    bob = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, title: "Video 1", category_id: category.id)
    review = Fabricate(:review, user_id: bob.id, video_id: video.id)

    sign_in_user(alice)
    click_on_video(video)
    click_on_user_name(bob)
    expect_user_to_be_followable(bob)
    
    follow_user(bob)
    expect_user_to_be_followed(bob)
    
    click_on_user_name(bob)
    expect_user_not_to_be_followable(bob)

    visit people_path
    unfollow_leader(bob)
    expect_user_not_to_be_followed(bob)
    
    visit home_path
    click_on_video(video)
    click_on_user_name(bob)
    expect_user_to_be_followable(bob)
  end
end

def expect_user_to_be_followable(user)
  expect(page).to have_content("Follow")
end

def expect_user_not_to_be_followable(user)
  expect(page).not_to have_content("Follow")
end

def follow_user(user)
  click_link "Follow"
end

def unfollow_leader(user)
  find("a[data-method='delete']").click
end

def expect_user_to_be_followed(user)
  expect(page).to have_content("People I Follow")
  expect(page).to have_content("#{user.full_name}")
end

def expect_user_not_to_be_followed(user)
  expect(page).to have_content("People I Follow")
  expect(page).not_to have_content("#{user.full_name}")
end

def click_on_video(video)
  find("a[href='/videos/#{video.id}']").click
end

def click_on_user_name(user)
  click_link "#{user.full_name}"
end