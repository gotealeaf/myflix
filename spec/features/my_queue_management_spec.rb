require 'spec_helper'

feature 'My Queue management' do
  given!(:first_video) { Fabricate(:video) }
  given!(:second_video) { Fabricate(:video) }
  given!(:third_video) { Fabricate(:video) }

  background do
    adam = Fabricate(:user)
    sign_in(adam)
  end

  scenario 'User adds a video to their queue and then access it from the queue' do
    find(:xpath, "//a[@href='#{video_path(first_video)}']").click
    click_on '+ My Queue'
    click_on 'My Queue'
    expect(page).to have_content("#{first_video.title}")
  end

  scenario 'User adds a video to their queue and verifies, then removes it' do
    find(:xpath, "//a[@href='#{video_path(first_video)}']").click
    click_on '+ My Queue'
    click_on 'My Queue'
    click_on "#{first_video.title}"
    click_on '- My Queue'
    click_on 'My Queue'
    expect(page).not_to have_content("#{first_video.title}")
  end

  scenario 'User adds multiple videos to their queue and then reorders them' do
    find(:xpath, "//a[@href='#{video_path(first_video)}']").click
    click_on '+ My Queue'
    click_on 'Videos'
    find(:xpath, "//a[@href='#{video_path(second_video)}']").click
    click_on '+ My Queue'
    click_on 'Videos'
    find(:xpath, "//a[@href='#{video_path(third_video)}']").click
    click_on '+ My Queue'
    click_on 'My Queue'
    fill_in "user[queue_item][#{first_video.id}][position]", with: 3
    fill_in "user[queue_item][#{second_video.id}][position]", with: 1
    fill_in "user[queue_item][#{third_video.id}][position]", with: 2
    click_on 'Update Instant Queue'
    expect(find_field("user_queue_item_#{first_video.id}_position").value).to eq('3')
    expect(find_field("user_queue_item_#{second_video.id}_position").value).to eq('1')
    expect(find_field("user_queue_item_#{third_video.id}_position").value).to eq('2')
  end
end
