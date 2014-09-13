require 'spec_helper'


feature 'user interacts with queue' do
  background do
    @mystery = Fabricate(:category)
    @monk = Fabricate(:video, category: @mystery)
    @conk = Fabricate(:video, category: @mystery)
    @donk = Fabricate(:video, category: @mystery)
  end

  scenario 'user reorders videos in queue' do
    sign_in
    find("a[href='/videos/1']").click
    page.should have_content @monk.title

    page.should have_content('+ My Queue')
    click_link('+ My Queue')
    page.should have_content "Video Title"
    page.should have_content @monk.title
    click_link(@monk.title)
    page.should have_content @monk.description
    page.should_not have_content('+ My Queue')

    visit videos_path
    find("a[href='/videos/2']").click
    click_link('+ My Queue')

    visit videos_path
    find("a[href='/videos/3']").click
    click_link('+ My Queue')

    visit my_queue_path

    # fill_in 'queue_item_1', :with => '6'    
    # fill_in 'queue_item_2', :with => '5'    
    # fill_in 'queue_item_3', :with => '4'    


    find("input[data-video-id='1']").set(6)
    find("input[data-video-id='2']").set(5)
    find("input[data-video-id='3']").set(4)
    click_button 'Update Instant Queue'
    page.should have_content "Your queue has been updated"

    find("input[data-video-id='1']").value.should == "3"
    find("input[data-video-id='2']").value.should == "2"
    find("input[data-video-id='3']").value.should == "1"




  end

end
