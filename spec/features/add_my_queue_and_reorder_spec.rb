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

    sign_in  
    Video.all.each do |video|
      add_video_to_queue(video.id)
      expect_video_to_be_in_the_queue(video)
      click_link video.title
      expect_link_not_be_see "+ My Queue"
    end

    #check list order and rearrange
    visit my_queue_path
    check_filled_in_list_order_is [1,2,3]
    fill_in_list_orders_as [3,2,1]
    click_button "Update Instant Queue"
    check_filled_in_list_order_is [3,2,1]

  end

  def fill_in_list_orders_as(order_array)
    order_array.each_with_index do |index, val|
      fill_in "queue_items[#{index}][position]" , with: val
    end
  end

  def check_filled_in_list_order_is(order_array)
    list_order = Video.all.each.map{ |video| find("#queue_items_#{video.id}_position").value.to_i }
    expect(list_order).to eq order_array
  end

  def expect_video_to_be_in_the_queue(video)
      expect(page).to have_content video.title
  end
  
  def add_video_to_queue(id)
      visit videos_path
      find("a[href='/videos/#{id}']").click
      click_link "+ My Queue"
  end

  def sign_in
    visit root_path
    click_link "Sign In"
    fill_in 'Name', with: @user.name
    fill_in 'Password', with: @user.password
    click_button "Login"
  end
end
