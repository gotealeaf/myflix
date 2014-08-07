require 'spec_helper'

feature "Interaction with my queue" do
  let!(:cat) { Fabricate(:category) }
  let!(:video1) { Fabricate(:video, category: cat) }
  let!(:video2) { Fabricate(:video, category: cat) }
  let!(:video3) { Fabricate(:video, category: cat) }

  scenario "add and reorder queue items" do
    sign_in
    add_video_to_queue(video1)
    add_video_to_queue(video2)
    add_video_to_queue(video3)

    set_video_ranking(video1, 3)
    set_video_ranking(video2, 1)
    set_video_ranking(video3, 2)
    click_button "Update Queue"

    expect_video_ranking(video1, 3)
    expect_video_ranking(video2, 1)
    expect_video_ranking(video3, 2)
  end

  def add_video_to_queue(video)
    visit root_path
    click_on_video_on_home_page(video)
    page.should have_content(video.title)
    click_link "+ My Queue"
    page.should have_content(video.title)
  end

  def set_video_ranking(video, ranking)
    find("input[data-video-id='#{video.id}']").set(ranking)
  end

  def expect_video_ranking(video, ranking)
    expect(find("input[data-video-id='#{video.id}']").value).to eq(ranking.to_s)
  end
end
