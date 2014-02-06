require 'spec_helper'

feature "test people i follow functionality" do

  let!(:biographies) { Fabricate(:category) }
  let!(:gandhi) { Fabricate(:video, title: "Gandhi", category: biographies) }
  let!(:alice) { Fabricate(:user) }
  let!(:review) { Fabricate(:review, video: gandhi, user: alice) }

  scenario "follow and un-follow" do
    sign_in
    go_to_video_from_home(gandhi)
    go_to_user(alice)
    follow_user
    go_to_people
    verify_user_on_list(alice)
    go_to_user(alice)
    verify_follow_button_is_gone
    go_to_people
    remove_user(alice)
    verify_user_not_on_list(alice)
  end

  private

  def go_to_video_from_home(video)
    click_link "Videos"
    expect(current_path).to eq(videos_path)
    find("a[href='/videos/#{video.id}']").click
    expect(current_path).to eq(video_path(video))
    expect(page).to have_content video.title
  end

  def go_to_user(user)
    click_link user.full_name
  end

  def follow_user
    click_button "Follow"
  end

  def go_to_people
    click_link "People"
  end

  def verify_user_on_list(user)
    expect(page).to have_content(user.full_name)
  end

  def verify_follow_button_is_gone
    expect(page).not_to have_content "Follow"
  end

  def remove_user(user)
    find("a[href='/relationships/#{user.id}']").click
  end

  def verify_user_not_on_list(user)
    expect(page).not_to have_content(user.full_name)
  end
end