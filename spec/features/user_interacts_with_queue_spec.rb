require 'spec_helper'

feature "user interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    monk = Fabricate(:video, title: "Monk")
    futurama = Fabricate(:video, title: "Futurama")
    south_park = Fabricate(:video, title: "South Park")
    sign_in_user
  end
end