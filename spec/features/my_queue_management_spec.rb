require 'spec_helper'

feature 'My Queue management' do
  given!(:first_video) { Fabricate(:video) }
  given!(:second_video) { Fabricate(:video) }
  given!(:third_video) { Fabricate(:video) }

  background do
    sign_in
  end

  scenario 'User adds a video to their queue and then access it from the queue' do
    find(:xpath, "//a[@href='#{video_path(first_video)}']").click
    expect(page).to have_content(first_video.title)
    click_on '+ My Queue'
    expect(page).not_to have_content('+ My Queue')
    click_on 'My Queue'
    expect(page).to have_content("#{first_video.title}")
  end

  scenario 'User adds a video to their queue and verifies, then removes it' do
    find(:xpath, "//a[@href='#{video_path(first_video)}']").click
    click_on '+ My Queue'
    click_on 'My Queue'
    click_on "#{first_video.title}"
    click_on '- My Queue'
    click_on 'My Queue'
    expect(page).not_to have_content("#{first_video.title}")
  end

  scenario 'User adds multiple videos to their queue and then reorders them' do
    find(:xpath, "//a[@href='#{video_path(first_video)}']").click
    click_on '+ My Queue'
    click_on 'Videos'
    find(:xpath, "//a[@href='#{video_path(second_video)}']").click
    click_on '+ My Queue'
    click_on 'Videos'
    find(:xpath, "//a[@href='#{video_path(third_video)}']").click
    click_on '+ My Queue'
    click_on 'My Queue'

    within(:xpath, "//tr[contains(.,'#{first_video.title}')]") do
      fill_in "queue_items[][position]", with: 3
    end

    within(:xpath, "//tr[contains(.,'#{second_video.title}')]") do
      fill_in "queue_items[][position]", with: 1
    end

    within(:xpath, "//tr[contains(.,'#{third_video.title}')]") do
      fill_in "queue_items[][position]", with: 2
    end

    click_on 'Update Instant Queue'
    expect(find(:xpath, "//tr[contains(.,'#{first_video.title}')]//input[@id='queue_items__position']").value).to eq('3')
    expect(find(:xpath, "//tr[contains(.,'#{second_video.title}')]//input[@id='queue_items__position']").value).to eq('1')
    expect(find(:xpath, "//tr[contains(.,'#{third_video.title}')]//input[@id='queue_items__position']").value).to eq('2')
  end
end
