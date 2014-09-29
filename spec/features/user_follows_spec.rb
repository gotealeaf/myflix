require 'spec_helper'


feature 'user follows and unfollows another user' do



  scenario 'user follows another user' do
    joe = Fabricate(:user)
    hank = Fabricate(:user)
    mystery = Fabricate(:category)
    video1 = Fabricate(:video, category: mystery)
    review1 = Fabricate(:review, video: video1, user: joe)
    sign_in(hank)
    click_on_video_on_home_page(video1)
    page.should have_content video1.title

    click_link(joe.full_name)
 
    page.should have_content 'Follow'

    click_link('Follow')
    page.should have_content "People I Follow"
    page.should have_content joe.full_name

    unfollow_user
    expect(page).to_not have_content joe.full_name

  end

def unfollow_user
    find("a[data-method='delete']").click
end


end
