require 'spec_helper'

feature "follow_feature" do
  scenario " with a user and a person to follow having reviews" do

    alice = Fabricate(:user, full_name: 'Alice Wonderland')
    sign_in(alice)
    comedies = Fabricate(:category, name: 'Comedies')
    stripes = Fabricate(:video, category: comedies, title: "Stripes")
    glowing_review = Fabricate(:review, video: stripes, user: alice, rating: 5, content: "It was great!")
    queue_item = Fabricate(:queue_item, video: stripes, user: alice)
    
    click_on_video_on_home_page(stripes)
    confirm_review_from(alice)

    test_profile_link_for(alice)
    confirm_queue_item_for(stripes)
    confirm_review_from(alice)
    confirm_review_count_for(alice)
    confirm_button_absence("Follow")
  
    bob = Fabricate(:user, full_name: "Bob")
    bobs_review = Fabricate(:review, video: stripes, user: bob, rating: 4, content: "I like army flicks.")

    visit video_path(stripes)
    test_profile_link_for(bob)
    confirm_button_presence "Follow"

    test_follow_for(bob)
    visit_profile_for(bob)
    confirm_button_absence "Follow"

    page.should have_content "People"
    click_link "People"
    test_unfollow_for(bob)
  end
end

def confirm_button_presence(name)
    page.should have_content name
end

def confirm_button_absence(name)
    page.should_not have_content name
end

def test_follow_for(user)
    click_link "Follow"
    page.should have_css 'h2', text: "People I Follow"
    page.should have_content(user.full_name)
end

def test_unfollow_for(leader)
  within(:xpath, "//tr[contains(.,'#{leader.full_name}')]") do
    # find("a[data-method='delete']").click
    find("a[data-method='delete']").click
  end
    page.should have_css 'h2', text: "People I Follow"
    page.should_not have_content(leader.full_name)
end

def visit_profile_for(user)
    visit user_path(user)
end

def test_profile_link_for(user)
  click_link(user.full_name) 
  page.should have_content(user.full_name)   
end

def confirm_review_from(user)
    page.should have_content(user.full_name) 
    page.should have_content(user.reviews.first.content) 
end

def confirm_queue_item_for(video)
    page.should have_content video.category.name
    page.should have_content video.title
end

def confirm_review_count_for(user)
     page.should have_content user.reviews.count
end