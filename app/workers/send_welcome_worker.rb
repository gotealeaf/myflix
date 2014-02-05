class SendWelcomeWorker
  include Sidekiq::Worker

  def perform(user_id)
    @user = User.find(user_id)
    AppMailer.send_welcome_email(@user).deliver
  end
end
