require 'spec_helper'

feature "user interacts with the people page" do 
  scenario "user follows a person and then unfollows them" do
    alice = Fabricate(:user)
    bob = Fabricate(:user)
    category1 = Fabricate(:category)
    video = Fabricate(:video, title: "Video 1", category_id: category1.id)
    review = Fabricate(:review, user_id: bob.id, video_id: video.id)

    sign_in_user(alice)
    visit_video_page(video)
    click_user_name(bob)
    expect_user_to_be_followable(bob)
    
    follow_user(bob)
    expect_user_to_be_followed(bob)
    
    click_user_name(bob)
    expect_user_not_to_be_followable(bob)

    visit people_path
    delete_leader(bob)
    expect_user_not_to_be_followed(bob)
    
    visit_video_page(video)
    click_user_name(bob)
    expect_user_to_be_followable(bob)
    #save_and_open_page
    #find(:xpath, "//tr[contains(.,'#{bob.full_name}')]//td//a[data-method='delete']").click
    #find("#delete_1").click
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

#user not relevant yet... waiting for xpath refactor from solution
def delete_leader(user)
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

def visit_video_page(video)
  visit home_path
  find("a[href='/videos/#{video.id}']").click
end

def click_user_name(user)
  click_link "#{user.full_name}"
end