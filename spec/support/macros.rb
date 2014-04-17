def set_current_user
  user = Fabricate(:user)
  session[:user_id] = user
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def visit_and_add_to_queue(video)
  visit home_path
  find(:xpath, ".//a[@href='/videos/#{video.id}']" ).click
  click_link '+ My Queue'
end


def check_queue_placement(video, user, position)
  within(:xpath, ".//tbody//tr[#{position}]") do
    expect(page).to have_content video.title
    expect(page).to have_xpath(".//input[@value='#{QueueItem.where(user: user, video: video).first.position}']")
  end
end

def fill_in_queue_position(current_position, new_position)
  within(:xpath, ".//tbody//tr[#{current_position}]") { fill_in( 'queue_items__position', with: new_position ) }
end