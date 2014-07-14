def user
  @user ||= Fabricate(:user)
end

def set_session_user
  session[:username] = user.username
end

def video
  @video ||= Fabricate(:video)
end

def genre
  @genre ||= Fabricate(:genre, name: 'action')
end
