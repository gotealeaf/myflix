require 'spec_helper'

feature "user social networking tools" do
  scenario "user following and unfollowing another user" do
    comedy = Category.create(name: "comedy")
    #comedies = Fabricate(:category) # because on the home page, videos are ordered by category
    monk = Fabricate(:video, title: "Monk")
    monk.categories << comedy
    
    jane = Fabricate(:user)
    sign_in_user(jane)
    
    visit home_path
    find("a[href='/videos/#{monk.id}']").click # find the video by ID position
    find #to be continued!!
    click_link "+ My Queue"
    
    
  end
end