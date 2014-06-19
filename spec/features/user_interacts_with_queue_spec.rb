require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do

    comedies = Fabricate(:category)
    monk = Fabricate(:video, title: "Monk", category: comedies)
    south_park = Fabricate(:video, title: "South Park", category: comedies)
    futurama = Fabricate(:video, title: "Futurama", category: comedies)

    sign_in
    find("a[href='/video/#{monk.id}']").click
    page.should have_content(monk.title)

  end
end