require 'spec_helper'

feature "user_interaction_with_queue" do
  scenario "user adds, deletes, and reorders videos in the queue" do
    
   category1 = Fabricate(:category, name: "Category1")
   # fabricate_video_for_category1(video1, category1)
   video1 = Fabricate(:video, title: "Video1", category: category1)
   video2 = Fabricate(:video, title: "Video2",category: category1)
   video3 = Fabricate(:video, title: "Video3",category: category1)

    
    
    sign_in
    visit home_path
    add_video_to_queue(video1)    
    confirm_addition_to_queue(video1)
    
    confirm_genre(video1)
    
    confirm_absence_of_add_to_queue_button_on_show_page(video1)

    add_video_to_queue(video2)
    expect_video_position(video2,2)

    add_video_to_queue(video3)

    set_video_position(video1,10)
    set_video_position(video2, 2)
    set_video_position(video3, 5)
    update_queue
    expect_video_position(video1,3)
    expect_video_position(video2,1)
    expect_video_position(video3,2)

    delete_queue_item(video2)
    confirm_deletion(video2)
    expect_video_position(video3,1)

    change_rating(video3,3)
    update_queue
    confirm_rating(video3,3) 

    change_rating(video1,nil)
    update_queue
    confirm_rating(video1,nil) 

  end
end

def confirm_genre(video)
  page.should have_content video.category.name
end

def change_rating(video,rating) 
   within(:xpath, "//tr[contains(.,'#{video.title}')]") do
    # find("#queue_items__rating").set(rating)
    select rating, from: 'queue_items__rating'
  end
end  

def confirm_rating(video,rating)
   within(:xpath, "//tr[contains(.,'#{video.title}')]") do
    expect(find("#queue_items__rating").value).to eq(rating.to_s)
  end
end
  


 def delete_queue_item(video)
   within(:xpath, "//tr[contains(.,'#{video.title}')]") do
     find("a[data-method='delete']").click
  end
end

def confirm_deletion(video)
   page.should_not have_content video.title
end


#the following method doesn't work
def fabricate_video_for_category1(video, category)
   video.to_sym = Fabricate(:video, title: "#{video.to_s.capitalize}", category: category)
end

def add_video_to_queue(video)
  visit home_path
  find("a[href='#{video_path(video)}']").click
  click_link("+ My Queue")
end

def confirm_addition_to_queue(video)
  page.should have_content video.title
end

def confirm_absence_of_add_to_queue_button_on_show_page(video)
  visit video_path(video)
  page.should_not have_content "+ My Queue"
end

def set_video_position(video,position)
  within(:xpath, "//tr[contains(.,'#{video.title}')]") do
    fill_in 'queue_items[][position]', with: position
  end
end

def update_queue
   click_button "Update Instant Queue"
end

def expect_video_position(video,position)
  expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)            
end

  