require 'rails_helper'

feature 'User manipualtes their queue' do

  scenario 'adds video to queue and then changes positions' do
    comics = Fabricate(:category)
    batman = Fabricate(:video, title: 'The Dark Knight', description: 'The saga returns', category: comics)
    superman = Fabricate(:video, title: 'Smallville', description: 'Small things are super', category: comics)
    spiderman = Fabricate(:video, title: 'The Incredible Spiderman', description: '8 legs are better than 2', category: comics)

    sign_in

    add_video_to_queue(batman)
    expect_video_to_be_queued(batman)

    visit video_path(batman)
    expect_link_not_to_be_present("+ My Queue")

    add_video_to_queue(superman)
    add_video_to_queue(spiderman)  

    set_video_position(batman,3)
    set_video_position(superman,2)
    set_video_position(spiderman,1)

    update_queue

    expect_video_position(batman,3)
    expect_video_position(superman,2)
    expect_video_position(spiderman,1)
  end

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link "+ My Queue"
  end

  def set_video_position(video,position)
    find("input[data-video-id='#{video.id}']").set(position)
  end

  def expect_video_position(video,position)
    expect(find("input[data-video-id='#{video.id}']").value).to eq(position.to_s)
  end
  
  def expect_video_to_be_queued(video)
    expect(page).to have_content(video.title)
  end
  
  def expect_link_not_to_be_present(link_text)
    expect(page).not_to have_content(link_text)
  end
  
  def update_queue
     click_button 'Update Instant Queue'
  end


end