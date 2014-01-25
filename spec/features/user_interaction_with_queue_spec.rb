require 'spec_helper'

feature "user_interaction_with_queue" do
  scenario "user adds, deletes, and reorders videos in the queue" do
   category1 = Fabricate(:category, name: "Category1")
   video1 = Fabricate(:video, title: "Video1", category: category1)
   video2 = Fabricate(:video, title: "Video2",category: category1)
   video3 = Fabricate(:video, title: "Video3",category: category1)



    sign_in
    # require 'pry'; binding.pry
    # require 'pry'; binding.pry
    # find("a[href='/videos/1']").click
   # click_link("video_1)
     
     # find('#video_1').click
    # find(alt="Video1").click

    find("a[href='#{video_path(video1)}']").click
     page.should have_content video1.title


      #add a video to the queue
      click_link("+ My Queue")
      page.should have_content video1.title

      #confirme queue button disappears 
      visit video_path(video1)
      page.should_not have_content "+ My Queue"

      #put 2 more videos in the queue
      visit home_path
      find("a[href='#{video_path(video2)}']").click
      click_link("+ My Queue")
      visit home_path
      find("a[href='#{video_path(video3)}']").click
      click_link("+ My Queue")

      #change queue order

      #find and set with id
      fill_in "video_#{video1.id}", with: 2
      fill_in "video_#{video2.id}", with: 3
      fill_in "video_#{video3.id}", with: 1
      click_button "Update Instant Queue"
      expect(find("#video_#{video1.id}").value).to eq("2")
      expect(find("#video_#{video2.id}").value).to eq("3")
      expect(find("#video_#{video3.id}").value).to eq("1")

      #find and set with data attribute

      find("input[data-video-id='#{video1.id}']").set(3)
      find("input[data-video-id='#{video2.id}']").set(1)
      find("input[data-video-id='#{video3.id}']").set(2)
      click_button "Update Instant Queue"
      expect(find("input[data-video-id='#{video1.id}']").value).to eq("3")
      expect(find("input[data-video-id='#{video2.id}']").value).to eq("1")
      expect(find("input[data-video-id='#{video3.id}']").value).to eq("2")


      #find using xpath

      within(:xpath, "//tr[contains(.,'#{video1.title}')]") do
        fill_in 'queue_items[][position]', with: 6
      end
       within(:xpath, "//tr[contains(.,'#{video2.title}')]") do
        fill_in 'queue_items[][position]', with: 7
      end

      within(:xpath, "//tr[contains(.,'#{video3.title}')]") do
        fill_in 'queue_items[][position]', with: 8
      end

      click_button "Update Instant Queue"
      expect(find(:xpath, "//tr[contains(.,'#{video1.title}')]//input[@type='text']").value).to eq("1")    
      expect(find(:xpath, "//tr[contains(.,'#{video2.title}')]//input[@type='text']").value).to eq("2")    
      expect(find(:xpath, "//tr[contains(.,'#{video3.title}')]//input[@type='text']").value).to eq("3")    
     

        






# feature "user interacts with queue" do
#   scenario "add and reorder queue" do
#     movie = Fabricate(:category, name: "movie")
#     monk = Fabricate(:video, title: 'Monk', category: movie)
#     mib = Fabricate(:video, title: 'MIB', category: movie)
#     batman = Fabricate(:video, title: 'Batman', category: movie)

#     sign_in

#     find("a[href='/videos/1']").click
#      page.should have_content "Monk"
    
    # add_video_to_queue(monk)
    # expect_video_to_be_in_queue(monk)
    # visit video_path(monk)
    # expect_link_not_to_be_seen("+ My Queue")






  end

end