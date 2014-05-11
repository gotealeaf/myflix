require 'spec_helper'

feature 'follow' do
  let(:sandy) { Fabricate(:user) }
  let(:video) { Fabricate(:video) }
  
  scenario "user follows another user" do
    Fabricate(:review, user: sandy, video: video )

    sign_in
    click_video_link_on_home_page(video)
    expect(page).to have_content sandy.full_name

    click_link sandy.full_name
    expect(page).to have_xpath("//input[@value='Follow']")

    click_button 'Follow'
    expect(page).to have_content "People I Follow"
    expect(page).to have_content sandy.full_name

    click_link sandy.full_name
    expect(page).to_not have_xpath('//input[@value="Follow"]') 
  end

  scenario "user unfollows a followee" do
    user = sign_in
    Fabricate(:user_relationship, followee: sandy, follower: user )

    click_link 'People'
    click_unfollow_link(sandy.full_name)
    expect(page).to_not have_content sandy.full_name
  end

  def click_unfollow_link(user_link_text)
    find(:xpath, "//tr/td/div[a = '#{user_link_text}']/../..//a[@data-method='delete']").click
  end
end