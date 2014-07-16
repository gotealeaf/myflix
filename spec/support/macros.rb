def user
  @user ||= Fabricate(:user)
end

def set_session_user
  session[:username] = user.username
end

def video(genre=nil)
  @video ||= Fabricate(:video, genre: genre)
end

def genre
  @genre ||= Fabricate(:genre, name: 'action')
end

def sign_in(usr=nil)
  user_email = usr ? usr.email : nil
  user_password = usr ? usr.password : nil
  visit sign_in_path
  fill_in 'email', with: user_email
  fill_in 'password', with: user_password
  click_button 'Sign in'
end
