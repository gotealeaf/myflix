def clear_current_user
  session[:user_id] = nil
end

def set_current_user
  session[:user_id] = user.id
end

def expect_link_not_be_see(link_string)
  expect(page).to_not have_content link_string
end
