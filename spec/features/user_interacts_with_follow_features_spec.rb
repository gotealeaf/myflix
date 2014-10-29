require 'spec_helper'

feature "user interacts with follow features" do
  scenario "user adds and removes people from following list" do
    darren = Fabricate(:user)
    larissa = Fabricate(:user)
    action = Category.create(name: "Action")
    star_wars = Fabricate(:video, title: "Star Wars")
    star_wars.categories << action
    review = Fabricate(:review, video: star_wars, reviewer: larissa)
    
    sign_in(darren)
    click_on_video_on_home_page(star_wars)
    
    click_link(larissa.full_name)
    click_link('Follow')
    expect(page).to have_content(larissa.full_name)
    
    unfollow_user(larissa)
    expect(page).to have_no_content(larissa.full_name)
  end
  
  def unfollow_user(user)
    find("a[href='/users/#{user.id}/unfollow']").click
  end
end