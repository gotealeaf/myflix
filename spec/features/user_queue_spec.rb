require "spec_helper"

feature "user interacts with the queue" do
  scenario "authenticated user adds videos to their queue and updates the videos' position" do
    jamie = Fabricate(:user)
    category = Fabricate(:category)
    video1 = Fabricate(:video, category: category)
    video2 = Fabricate(:video, category: category)

    sign_in(jamie)

    add_video_to_queue(video1)
    expect_video_to_be_in_queue(video1)
    
    visit video_path(video1)
    expect_link_to_dissapear("+ My Queue")
  
    add_video_to_queue(video2)

    visit my_queue_path
    set_position_in_queue(video1, 2)
    set_position_in_queue(video2, 1)

    click_update_queue

    expect_position_in_queue(video1, 2)
    expect_position_in_queue(video2, 1)
  end

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link "+ My Queue"
  end

  def expect_link_to_dissapear(link)
    expect(page).to_not have_content link
  end

  def expect_video_to_be_in_queue(video)
    expect(page).to have_content video.title
  end

  def set_position_in_queue(video, position)
    fill_in "video_#{video.id}", with: position
  end

  def click_update_queue
    click_button "Update Instant Queue"
  end

  def expect_position_in_queue(video, position)
    expect(find("#video_#{video.id}").value).to eq(position.to_s)
  end



  #scenario "user goes to my queue page and the video is in the queue"
  #scenario "from the queue the user goes to video show page by clicking on video"
  #scenario "the video show page will not have the add to queue button when the video is already in the queue"
end