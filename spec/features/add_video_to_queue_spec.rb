require 'rails_helper'

feature 'User manipualtes their queue' do
  
  scenario 'adds video to queue and then changes positions' do
    comics = Fabricate(:category)
    batman = Fabricate(:video, title: 'The Dark Knight', description: 'The saga returns', category: comics)
    superman = Fabricate(:video, title: 'Smallville', description: 'Small things are super', category: comics)
    spiderman = Fabricate(:video, title: 'The Incredible Spiderman', description: '8 legs are better than 2', category: comics)
    
    sign_in
    visit videos_path
    find("a[href='/videos/#{batman.id}']").click
    expect(page).to have_content('The saga returns')
    
    click_link "+ My Queue"
    expect(page).to have_content('The Dark Knight')
    
    visit video_path(batman)
    expect(page).not_to have_content("+ My Queue")
    
    visit home_path
    find("a[href='/videos/#{superman.id}']").click
    click_link "+ My Queue"
    
    visit home_path
    find("a[href='/videos/#{spiderman.id}']").click
    click_link "+ My Queue"
    
    find("input[data-video-id='#{batman.id}']").set(3)
    find("input[data-video-id='#{superman.id}']").set(2)
    find("input[data-video-id='#{spiderman.id}']").set(1)
    
    click_button 'Update Instant Queue'
    
    expect(find("input[data-video-id='#{batman.id}']").value).to eq('3')
    expect(find("input[data-video-id='#{superman.id}']").value).to eq('2')
    expect(find("input[data-video-id='#{spiderman.id}']").value).to eq('1')
    
  end
  
  
end