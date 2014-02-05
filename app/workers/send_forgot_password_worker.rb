class SendForgotPasswordWorker
  include Sidekiq::Worker

  def perform(user_id)
    @user = User.find(user_id)
    AppMailer.send_forgot_password(@user).deliver
  end
end
