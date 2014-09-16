require 'spec_helper'

feature "User can add and remove leaders" do 
  
  scenario "user logs in, looks at a video, selects a user in the video review, follows user" do
    karen = Fabricate(:user)
    bob = Fabricate(:user, full_name: "bob")

    comedies = Fabricate(:category) 
    monk = Fabricate(:video, title: "Monk", category: comedies)
    futurama = Fabricate(:video, title: "Futurama", category: comedies)
    south_park = Fabricate(:video, title: "South Park", category: comedies)
    review = Fabricate(:review, video: futurama, user: bob)

    sign_in(karen)
    page.should have_content karen.full_name

    click_on_video_on_home_page(futurama)
    click_link "bob"
    click_link "Follow"
    page.should have_content "People I Follow"
    page.should have_content bob.full_name

    unfollow(bob)
    page.should_not have_content(bob.full_name)
  end

  def unfollow(user)
   find("a[data-method='delete']").click 
  end
end