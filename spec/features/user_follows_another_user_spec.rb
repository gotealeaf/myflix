require 'spec_helper'

feature " user follows another user" do
  
  scenario " user clicks on a video and follows a user who has written a review " do

    comedies = Fabricate(:category)
    seinfeld = Fabricate(:video, title:"Seinfeld", category: comedies)
    gopal = Fabricate(:user, full_name: "Gopal Gopal")
    review = Fabricate(:review, user: gopal, video: seinfeld)

    sign_in

    visit home_path
    find_and_click_video_on_home_page(seinfeld)
    expect(page).to have_content(seinfeld.title)
    
    click_link gopal.full_name

    expect(page).to have_content(gopal.full_name)
    
    click_link("Follow")
    expect(page).to have_content(gopal.full_name)

    unfollow(gopal)

    expect(page).not_to have_content(gopal.full_name)

    visit "/users/#{gopal.slug}"
    expect(page).to have_link("Follow")




  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end

end
