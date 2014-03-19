def add_to_session(adam=nil)
  session[:user_id] = adam.present? ? adam.id : Fabricate(:user).id
end

def clear_user_from_session
  session[:user_id] = nil
end
