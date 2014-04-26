require 'spec_helper'

feature 'my queue' do
  let(:video) { Fabricate(:video) }

  scenario "user adds video to queue" do
    video
    
    sign_in

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
    video
    video_2 = Fabricate(:video)
    video_3 = Fabricate(:video)
    user = sign_in

    visit_and_add_video_to_queue(video)
    visit_and_add_video_to_queue(video_2)
    visit_and_add_video_to_queue(video_3)

    fill_in_video_position(video, 2)
    fill_in_video_position(video_2, 3)
    fill_in_video_position(video_3, 1)

    click_button 'Update Instant Queue'

    expect_video_position(video, 2)
    expect_video_position(video_2, 3)
    expect_video_position(video_3, 1)
  end

  def visit_and_add_video_to_queue(video)
    visit home_path
    find(:xpath, ".//a[@href='/videos/#{video.id}']" ).click
    click_link '+ My Queue'
  end

  def fill_in_video_position(video, position)
    within(:xpath, "//tr/td[a = '#{video.title}']/..") do
      fill_in 'queue_items__position', with: position
    end
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr/td[a = '#{video.title}']/..//input[@type='text']" ).value).to eq position.to_s
  end
end