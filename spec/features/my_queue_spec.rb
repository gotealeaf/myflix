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
    
    check_queue_placement(video, user, 1)
    fill_in_queue_position(1, 2)

    check_queue_placement(video_2, user, 2)
    fill_in_queue_position(2, 3)

    check_queue_placement(video_3, user, 3)
    fill_in_queue_position(3, 1)

    click_button 'Update Instant Queue'

    check_queue_placement(video_3, user, 1)
    check_queue_placement(video, user, 2)
    check_queue_placement(video_2, user, 3)
  end
end