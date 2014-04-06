require 'spec_helper'

feature "Follow Users" do
  given!(:joe)   { Fabricate(:user                          ) }
  given!(:jen)   { Fabricate(:user                          ) }
  given!(:drama) { Fabricate(:category, name: "Drama"       ) }
  given!(:monk)  { Fabricate(:video, title: "monk", categories: [drama]) }
  given!(:review){ Fabricate(:review, video: monk, user: jen) }

  scenario "User Joe Follows & Unfollows User Jen" do
    signin_user(joe)
    page.should have_content("Drama")

    click_video_image_link(monk)
    page.should have_content("Write Review")

    click_user_review_link(jen)
    page.should have_content("#{jen.name}'s video collections")

    click_link "Follow"
    page.should have_content("People I Follow")
    expect_user_in_people_followed_list(jen)

    click_to_remove_user_from_followed_list(jen)
    expect_user_removed_from_people_followed_list(jen)
  end
end

def click_user_review_link(user)
  click_link "by #{user.name}"
end

def click_to_remove_user_from_followed_list(user)
  find(:xpath, "//tr[contains(.,'#{user.name}')]//a[@data-method='delete']").click
end

def expect_user_in_people_followed_list(user)
  page.should have_selector "a", "#{user.name}"
end

def expect_user_removed_from_people_followed_list(user)
  expect(page.has_no_link?("#{user.name}")).to be_true
end
