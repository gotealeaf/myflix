require 'spec_helper'

feature "interaction_with_user_show_page" do
  scenario " click user to access page, find queue items and reviews" do

    alice = Fabricate(:user, full_name: 'Alice Wonderland')
    sign_in(alice)
    comedies = Fabricate(:category, name: 'Comedies')
    stripes = Fabricate(:video, category: comedies)
    glowing_review = Fabricate(:review, video: stripes, user: alice, rating: 5, content: "Specified Content")
    queue_item = Fabricate(:queue_item, video: stripes, user: alice)

    #user link should be present
    visit video_path(stripes)
    page.should have_content alice.full_name

    #link takes you to the users profile
    visit user_path(alice)
    click_link alice.full_name
    # require 'pry'; binding.pry
    page.should have_content alice.full_name
    page.should have_content comedies.name
    page.should have_content queue_item.video.title
    page.should have_content glowing_review.rating
    page.should have_content glowing_review.content


  end
end