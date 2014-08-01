def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit signin_path
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign In"
end
