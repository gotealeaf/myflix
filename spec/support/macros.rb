def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def sign_in(a_user=nil)
  user = a_user || Fabricate(:user, password: "password")
  visit root_path
  expect(page).to have_content "Unlimited"
  click_link "Sign In"
  expect(page).to have_content "Sign in"
  fill_in "email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  expect(page).to have_content user.full_name
end