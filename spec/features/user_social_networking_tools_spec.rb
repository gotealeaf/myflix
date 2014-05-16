require 'spec_helper'

feature "user social networking tools" do
  scenario "user following and unfollowing another user" do
    
    comedy = Category.create(name: "comedy")
    #comedies = Fabricate(:category) # because on the home page, videos are ordered by category
    monk = Fabricate(:video, title: "Monk")
    monk.categories << comedy
    
    jane = Fabricate(:user)
    bob = Fabricate(:user)
    review = Fabricate(:review, video: monk, user: bob)
    
    sign_in_user(jane)
    go_to_video_page(monk)
    find_user_to_follow(bob)  
    unfollow_user(bob) 
    
  end
  
  def go_to_video_page(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click # find the video by ID position
    page.should have_content(video.title)
  end

  def find_user_to_follow(user)
    click_link user.full_name
    page.should have_content("video collections")
    click_link "Follow"
    page.should have_content(user.full_name)
  end

  def unfollow_user(user)
    find("a[data-method='delete']").click #to find the exact delete link
    page.should_not have_content(user.full_name)
  end
end