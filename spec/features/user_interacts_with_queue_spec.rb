require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do

    action = Fabricate(:category)
    kungfu = Fabricate(:video, title: "Kung Fu", category: action)
    panda = Fabricate(:video, title: "Panda", category: action)
    transformers = Fabricate(:video, title: "Transformers", category: action)

    sign_in
    find("a[href='/videos/#{ kungfu.id }']").click
    page.should have_content(kungfu.title)

    click_link "+ My Queue"
    page.should have_content(kungfu.title)

    visit video_path(kungfu)
    page.should_not have_content("+ My Queue")

    visit home_path
    find("a[href='/videos/#{ panda.id }']").click
    click_link "+ My Queue"
    
    visit home_path
    find("a[href='/videos/#{ transformers.id }']").click
    click_link "+ My Queue"

    find("input[data-video-id='#{ kungfu.id }']").set(3)
    find("input[data-video-id='#{ panda.id }']").set(1)
    find("input[data-video-id='#{ transformers.id }']").set(2)

    click_button "Update Instant Queue"

    expect(find("input[data-video-id='#{ panda.id }']").value).to eq("1")
    expect(find("input[data-video-id='#{ transformers.id }']").value).to eq("2")
    expect(find("input[data-video-id='#{ kungfu.id }']").value).to eq("3")
  end
end
