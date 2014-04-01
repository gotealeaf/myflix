require 'spec_helper'

feature 'User interacts with the queue ' do
  scenario "user adds and reorders videos in the queue" do
    comedies = Fabricate(:category, name: 'Comedies')
    futurama = Fabricate(:video, title: 'Futurama', category: comedies)
    family_guy = Fabricate(:video, title: 'Family Guy', category: comedies)
    south_park = Fabricate(:video, title: 'South Park', category: comedies)

    visit sign_in_path
    user_signs_in
    find("a[href='/videos/#{futurama.id}']").click
    expect(page).to have_content(futurama.title)

    add_video_to_queue(futurama)
    page.has_content?('futurama.title')

    find("a[href='/videos/#{futurama.id}']").click
    visit(video_path(futurama))
    does_not_have_link("+ My Queue")

    add_video_to_queue(family_guy)
    add_video_to_queue(south_park)

    fill_in_position_value(futurama, 3)
    fill_in_position_value(family_guy, 1)
    fill_in_position_value(south_park, 2)

    click_button "Update Instant Queue"

    find_and_expect_value(family_guy, 1)
    find_and_expect_value(south_park, 2)
    find_and_expect_value(futurama, 3)
  end

  def fill_in_position_value(video, position_value)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position_value
    end
  end

  def find_and_expect_value(video, position_value)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position_value.to_s)
  end

  def does_not_have_link(link)
    page.should_not have_content(link)
  end

  def add_video_to_queue(video)
    visit videos_path
    find("a[href='/videos/#{video.id}']").click
    click_link("+ My Queue")
  end
end

#requires data: {video_id: item.video.id} in the dom
=begin
    find("input[data-video-id='#{futurama.id}']").set(3)
    find("input[data-video-id='#{family_guy.id}']").set(1)
    find("input[data-video-id='#{south_park.id}']").set(2)

    click_button "Update Instant Queue"

    expect(find("input[data-video-id='#{family_guy.id}']").value).to eq("1")
    expect(find("input[data-video-id='#{south_park.id}']").value).to eq("2")
    expect(find("input[data-video-id='#{futurama.id}']").value).to eq("3")


#requires id: "video_#{item.video.id}" # in the queue items index page
    fill_in "video_#{futurama.id}", with: 3
    fill_in "video_#{south_park.id}", with: 1
    fill_in "video_#{family_guy.id}", with: 2

    click_button "Update Instant Queue"

    expect(find("#video_#{south_park.id}").value).to eq("1")
    expect(find("#video_#{family_guy.id}").value).to eq("2")
    expect(find("#video_#{futurama.id}").value).to eq("3")
=end
  