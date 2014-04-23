require 'spec_helper'
require 'pry'

feature "login, add videos to queue and check queue works correctly" do

  given(:category) { Fabricate(:category) }
  given(:adam) { Fabricate(:user) }


  scenario 'adds video the queue' do

    sign_in

    video1 = Fabricate(:video, category: category)
    video2 = Fabricate(:video, category: category)
    video3 = Fabricate(:video, category: category)

    add_video_to_queue_and_verify_added_check_ui_for_button_removed(video1)
    add_video_to_queue_and_verify_added_check_ui_for_button_removed(video2)
    add_video_to_queue_and_verify_added_check_ui_for_button_removed(video3)

    go_to_queue_page

    update_queue_position(1, 10)
    update_queue_position(2, 1)
    update_queue_position(3, 4)

    click_button("Update Instant Queue")

    check_queue_displays_message

    check_queue_items_are_updated(1, 3)
    check_queue_items_are_updated(2, 1)
    check_queue_items_are_updated(3, 2)
  end

  def sign_in
    visit login_path
    fill_in "Email", :with => adam.email
    fill_in "Password", :with => adam.password
    click_button "Submit"
  end

  def check_queue_items_are_updated(queue_item_id, position)
    expect(find("#queue_item_#{queue_item_id}").value).to eq(position.to_s)
  end

  def check_queue_displays_message
    expect(page).to have_content "The order of the videos in your queue has been updasted."
  end

  def go_to_queue_page
    visit my_queue_path
  end

  def update_queue_position(queue_item_id, position)
    fill_in "queue_item_#{QueueItem.find(queue_item_id).id}", :with => position
  end

  def add_video_to_queue_and_verify_added_check_ui_for_button_removed(video)
    visit video_path(video)
    expect(page).to have_content "#{video.title}"
    click_link("+ My Queue")
    visit my_queue_path
    expect(page).to have_content "#{video.title}"
    visit video_path(video)
    expect(page).to_not have_content "+ My Queue"
  end

end
