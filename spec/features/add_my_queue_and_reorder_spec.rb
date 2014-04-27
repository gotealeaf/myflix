require 'spec_helper'
feature "add to my queue and rearrange list order" do
  background do
    sport = Fabricate(:category, name: "sport")

    #given(:user) { Fabricate(:user) }

    @user = Fabricate(:user)
    3.times do
      review = Fabricate(:review, user: @user)
      Fabricate(:video, category: sport) do
        reviews(count: 1) { review }
      end
    end
    #why can code as seed.rb does?
  end

  scenario "login, add to my_queue, check button invisible ,reordered check, delete check" do
    #Login
    visit root_path
    click_link "Sign In"
    fill_in 'Name', with: @user.name
    fill_in 'Password', with: @user.password
    click_button "Login"
    
    Video.all.each do |video|
      visit videos_path
      find("a[href='/videos/#{video.id}']").click
      expect(page).to have_content video.title
      #save_and_open_page
      click_link "+ My Queue"
      #check if adding to my queue
      expect(page).to have_content video.title
      #check + My Queue button is visible or not
      click_link video.title
      expect(page).to_not have_content "+ My Queue"
    end

    #check list order and rearrange

    visit my_queue_path

    list_order = Video.all.each.map{ |video| find("#queue_items_#{video.id}_position").value.to_i }
    expect(list_order).to eq [1,2,3]

    fill_in "queue_items[1][position]" , with: 3
    fill_in "queue_items[2][position]" , with: 2
    fill_in "queue_items[3][position]" , with: 1

    click_button "Update Instant Queue"

    list_order = Video.all.each.map{ |video| find("#queue_items_#{video.id}_position").value.to_i }
    expect(list_order).to eq [3,2,1]



  end
end
