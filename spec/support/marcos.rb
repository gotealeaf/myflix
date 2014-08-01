
def set_current_user
  current_user = Fabricate(:user)
  session[:user_id] = current_user.id
end

def current_user
  @current_user ||= User.find(session[:user_id])
end


def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit signin_path
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign In"
end
