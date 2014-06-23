require 'spec_helper'

feature "User interacts with the another people" do
  scenario "user follows another user and delete their relationship" do
    mafia = Fabricate :category
    the_wire = Fabricate :video, title: "The Wire", category: mafia
    ana = Fabricate :user
    review = Fabricate :review, creator: ana, video: the_wire

    sign_in

    click_on_video_on_home_page the_wire

    page.should have_content the_wire.title
    click_link ana.full_name

    page.should have_content "#{ana.full_name}'s video collections"
    click_link "Follow"

    page.should have_content "People I Follow"
    page.should have_content ana.full_name

    unfollow ana
    page.should_not have_content ana.full_name
  end
end

def unfollow user
  find("a[data-method='delete']").click
end