def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def set_current_admin(admin=nil)
  session[:user_id] = (admin || Fabricate(:admin)).id
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def sign_in(a_user=nil, admin=:user)
  user = a_user || Fabricate(admin, password: "password")
  follow_links_to_sign_in
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  expect(page).to have_content user.full_name
end

def sign_out
  visit sign_out_path
end

def click_on_video_on_home_page(video)
  find("a[href='/videos/#{video.id}']").click
end

def follow_links_to_sign_in
  visit root_path
  expect(page).to have_content "Unlimited"
  click_link "Sign In"
  expect(page).to have_content "Sign in"
end