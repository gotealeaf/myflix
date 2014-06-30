require 'rails_helper.rb'

feature "user interacts with queue" do
  scenario "user adds and reorders videos in queue" do
    comedies = Fabricate(:category)
    monk = Fabricate(:video, title: "Monk", category: comedies)
    futurama = Fabricate(:video, title: "Futurama", category: comedies)
    south_park = Fabricate(:video, title: "South Park", category: comedies)

    sign_in

    add_video_to_queue(monk)
    expect_video_to_be_in_queue(monk)

    visit video_path(monk)
    expect_link_to_be_hidden("+ My Queue")

    add_video_to_queue(futurama)
    add_video_to_queue(south_park)

    set_video_position(south_park, 1)
    set_video_position(futurama, 3)
    set_video_position(monk, 2)

    # using unique data attribute
    #   find("input[data-video-id='#{south_park.id}']").set(1)
    #   find("input[data-video-id='#{futurama.id}']").set(3)
    #   find("input[data-video-id='#{monk.id}']").set(2)


    # using id instead of data, fill_in won't work with custom data attribute
    #    fill_in "video_#{south_park.id}", with: 1
    #    fill_in "video_#{futurama.id}", with: 3
    #    fill_in "video_#{monk.id}", with: 2

    update_queue

    expect_video_position(south_park, 1)
    expect_video_position(futurama, 3)
    expect_video_position(monk, 2)

  end

  def expect_video_to_be_in_queue(video)
    expect(page).to have_content video.title
  end

  def expect_link_to_be_hidden(link_text)
    expect(page).not_to have_content link_text
  end

  def update_queue
    click_button 'Update Instant Queue'
  end

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link '+ My Queue'
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end
end
