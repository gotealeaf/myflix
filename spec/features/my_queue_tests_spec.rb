require 'spec_helper'

feature "test queue functionality" do
  
  let!(:biographies) { Fabricate(:category) }
  let!(:gandhi) { Fabricate(:video, title: "Gandhi", category: biographies) }
  let!(:schindlerslist) { Fabricate(:video, title: "Schindler's List", category: biographies) }
  let!(:reds) { Fabricate(:video, title: "Reds", category: biographies) }

  scenario "add, reorder, and delete videos from the queue" do
    sign_in
    
    add_video(gandhi)
    expect_video_to_be_in_queue(gandhi)
    go_to_video_from_queue(gandhi)
    expect_link_not_to_be_seen("+ My Queue")
    
    add_video(schindlerslist)
    expect_video_to_be_in_queue(schindlerslist)
    go_to_video_from_queue(schindlerslist)
    expect_link_not_to_be_seen("+ My Queue")

    add_video(reds)
    expect_video_to_be_in_queue(reds)
    go_to_video_from_queue(reds)
    expect_link_not_to_be_seen("+ My Queue")

    click_link "Videos"
    expect(current_path).to eq(videos_path)
    click_link "My Queue"
    expect(page).to have_content "List Order"
    
    set_video_ranking(gandhi, 4)
    set_video_ranking(schindlerslist, 3)
    set_video_ranking(reds, 5)
    
    update_queue
    
    check_video_ranking(gandhi, 2)
    check_video_ranking(schindlerslist, 1)
    check_video_ranking(reds, 3)
    
    remove_video(gandhi)
    check_video_ranking(reds, 2)
  end

  private

  def add_video(video)
    click_link "Videos"
    expect(current_path).to eq(videos_path)
    find("a[href='/videos/#{video.id}']").click
    expect(current_path).to eq(video_path(video))
    expect(page).to have_content video.title
    click_button "+ My Queue"
  end

  def expect_video_to_be_in_queue(video)
    expect(page).to have_content(video.title)
  end

  def expect_link_not_to_be_seen(link_text)
    expect(page).not_to have_button(link_text)
  end

  def update_queue
    click_button "Update Instant Queue"
  end

  def go_to_video_from_queue(video)
    expect(current_path).to eq(queue_items_path)
    expect(page).to have_content "List Order"
    expect(page).to have_content video.title
    click_link video.title
    expect(page).to have_content video.title
    expect(current_path).to eq(video_path(video))
  end

  def set_video_ranking(video, rank)
    fill_in "video#{video.id}", with: rank.to_s
  end

  def check_video_ranking(video, rank)
    expect(find_field("video#{video.id}").value).to eq(rank.to_s)
  end

  def remove_video(video)
    click_link "remove#{video.id}"
  end
end

