def user
  @user ||= Fabricate(:user)
end

def stripe_valid_token
  Stripe.api_key = Rails.application.secrets.stripe_sec_key
  @token = Stripe::Token.create(
    card:{
      number: "4242424242424242",
      exp_month: 12,
      exp_year: 2016,
      cvc: 123 }
    )
end

def stripe_invalid_token
  Stripe.api_key = Rails.application.secrets.stripe_sec_key
  @token = Stripe::Token.create(
    card:{
      number: "4000000000000002",
      exp_month: 12,
      exp_year: 2016,
      cvc: 123 }
    )
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
