require 'rails_helper'

feature "My Queue" do
  background { my_queue_feature_set_up }

  scenario 'user adds a video to queue' do
    sign_in(user)
    click_on(@video1.id)
    click_on('+ My Queue')
    expect(page).to have_content(@video1.name.titleize)
  end

  scenario 'user follow video link in queue to show page' do
    sign_in(user)
    click_on(@video1.id)
    click_on('+ My Queue')
    find_link(@video1.name.titleize).click
    expect(page).to have_content(@video1.description)
    expect(page).to_not have_content('+ My Queue')
  end

  scenario 'user adds multiple videos to queue' do
    sign_in(user)
    visit(video_path(@video1))
    click_on('+ My Queue')
    visit(video_path(@video2))
    click_on('+ My Queue')
    visit(video_path(@video3))
    click_on('+ My Queue')
    expect(page).to have_content(@video1.name.titleize)
    expect(page).to have_content(@video2.name.titleize)
    expect(page).to have_content(@video3.name.titleize)
    page.assert_selector("input[data-video-id]", count: 3)
  end

  scenario 'user reorders video in queue' do
    sign_in(user)
    visit(video_path(@video1))
    click_on('+ My Queue')
    visit(video_path(@video2))
    click_on('+ My Queue')
    visit(video_path(@video3))
    click_on('+ My Queue')
    visit(my_queue_path)
    find("input[data-video-id='#{@video1.id}']").set(5)
    find("input[data-video-id='#{@video2.id}']").set(6)
    find("input[data-video-id='#{@video3.id}']").set(4)
    click_button('Update Instant Queue')
    expect(find("input[data-video-id='#{@video.id}']").value).to eq("2")
    expect(find("input[data-video-id='#{@video2.id}']").value).to eq("3")
    expect(find("input[data-video-id='#{@video3.id}']").value).to eq("1")
  end

  scenario 'user deletes video from queue' do
    sign_in(user)
    visit(video_path(@video1))
    click_on('+ My Queue')
    visit(video_path(@video2))
    click_on('+ My Queue')
    visit(video_path(@video3))
    click_on('+ My Queue')
    visit(my_queue_path)
    find("a[href='#{queue_video_path(@video1.queue_videos.first.id)}']").click
    expect(find("input[data-video-id='#{@video2.id}']").value).to eq("1")
    expect(find("input[data-video-id='#{@video3.id}']").value).to eq("2")
  end
end
