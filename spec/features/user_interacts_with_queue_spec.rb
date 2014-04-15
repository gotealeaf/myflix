require 'spec_helper'

feature "user interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    category1 = Fabricate(:category)
    video1 = Fabricate(:video, title: "Video 1", category_id: category1.id)
    video2 = Fabricate(:video, title: "Video 2", category_id: category1.id)
    video3 = Fabricate(:video, title: "Video 3", category_id: category1.id)
    alice = Fabricate(:user)
    sign_in_user(alice)
    find("a[href='/videos/#{video1.id}']").click
    expect(page).to have_content video1.title
    click_link "+ My Queue"
    expect(page).to have_content video1.title
    click_link "#{video1.title}"
    expect(page).to have_content video1.title
    expect(page).not_to have_content "+ My Queue"
    add_video_to_queue(video2)
    add_video_to_queue(video3)
    expect(page).to have_content video2.title
    first("td input.form-control#queue_items__position[value='3']").set('1')
    first("td input.form-control#queue_items__position[value='1']").set('3')
    click_button "Update Instant Queue"
    expect(first("td a")).to have_content video3.title
  end 
end