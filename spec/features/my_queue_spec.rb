require 'spec_helper'

feature 'my queue' do
  let(:user) { Fabricate(:user, password: 'password', password_confirmation: 'password') }
  let(:video) { Fabricate(:video) }

  background do
    video
    visit sign_in_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  scenario "user adds video to queue" do
    find(:xpath, ".//a[@href='/videos/#{video.id}']" ).click
    expect(page).to have_content video.title
    expect(page).to have_content 'Watch Now'
    click_link '+ My Queue'
    expect(page).to have_content 'List Order'
    expect(page).to have_content video.title
    click_link video.title
    expect(page).to have_content video.title
    expect(page).to have_content 'Watch Now'
    expect(page).to_not have_content '+ My Queue'
  end

  scenario "user reorders videos in queue" do
    video_2 = Fabricate(:video)
    video_3 = Fabricate(:video)
    visit_and_add_to_queue(video)
    visit_and_add_to_queue(video_2)
    visit_and_add_to_queue(video_3)
    
    within(:xpath, ".//tbody//tr[1]") do
      expect(page).to have_content video.title
      expect(page).to have_xpath(".//input[@value='#{QueueItem.where(user: user, video: video).first.position}']")
      fill_in( 'queue_items__position', with: 2 )
    end

    within(:xpath, ".//tbody//tr[2]") do
      expect(page).to have_content video_2.title
      expect(page).to have_xpath(".//input[@value='#{QueueItem.where(user: user, video: video_2).first.position}']")
      fill_in( 'queue_items__position', with: 3 )
    end

    within(:xpath, ".//tbody//tr[3]") do
      expect(page).to have_content video_3.title
      expect(page).to have_xpath(".//input[@value='#{QueueItem.where(user: user, video: video_3).first.position}']")
      fill_in( 'queue_items__position', with: 1 )
    end

    click_button 'Update Instant Queue'

    within(:xpath, ".//tbody//tr[1]") do
      expect(page).to have_content video_3.title
      expect(page).to have_xpath(".//input[@value='#{QueueItem.where(user: user, video: video_3).first.position}']")
    end

    within(:xpath, ".//tbody//tr[2]") do
      expect(page).to have_content video.title
      expect(page).to have_xpath(".//input[@value='#{QueueItem.where(user: user, video: video).first.position}']")
    end

    within(:xpath, ".//tbody//tr[3]") do
      expect(page).to have_content video_2.title
      expect(page).to have_xpath(".//input[@value='#{QueueItem.where(user: user, video: video_2).first.position}']")
    end 
  end
end