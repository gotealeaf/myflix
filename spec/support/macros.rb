def user
  @user ||= Fabricate(:user)
end

def set_session_user
  session[:username] = user.username
end

def clear_session_user
  session[:username] = nil
end

def set_session_admin
  set_session_user
  user.update(admin: true)
end

def video
  @video ||= Fabricate(:video, genre: genre)
end

def genre
  @genre ||= Fabricate(:genre, name: 'action')
end

def user_signs_in(usr=nil)
  user_email = usr ? usr.email : nil
  user_password = usr ? usr.password : nil
  visit sign_in_path
  fill_in 'email', with: user_email
  fill_in 'password', with: user_password
  click_button 'Sign in'
end

def user_signs_out
  click_on 'Sign out'
end
