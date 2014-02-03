require 'spec_helper'

feature 'My Queue management' do
  given!(:first_video) { Fabricate(:video) }
  given!(:second_video) { Fabricate(:video) }
  given!(:third_video) { Fabricate(:video) }

  background do
    sign_in
  end

  scenario 'User adds a video to their queue and then access it from the queue' do
    find(:xpath, "//a[@href='#{video_path(first_video)}']").click
    expect(page).to have_content(first_video.title)
    click_on '+ My Queue'
    expect(page).not_to have_content('+ My Queue')
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
    add_video_to_queue(first_video)
    add_video_to_queue(second_video)
    add_video_to_queue(third_video)

    browse_my_queue

    assign_position_to_video(3, first_video)
    assign_position_to_video(1, second_video)
    assign_position_to_video(2, third_video)

    update_instant_queue

    expect_video_to_have_position(first_video, 3)
    expect_video_to_have_position(second_video, 1)
    expect_video_to_have_position(third_video, 2)
  end
end

def add_video_to_queue(video)
  click_on 'Videos'
  find(:xpath, "//a[@href='#{video_path(video)}']").click
  click_on '+ My Queue'
end

def browse_my_queue
  click_on 'My Queue'
end

def assign_position_to_video(position, video)
  within(:xpath, "//tr[contains(.,'#{video.title}')]") do
    fill_in "queue_items[][position]", with: position
  end
end

def update_instant_queue
  click_on 'Update Instant Queue'
end

def expect_video_to_have_position(video, position)
  expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@id='queue_items__position']").value).to eq(position.to_s)
end
