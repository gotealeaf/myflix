class EmailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id)
    user = User.find(user_id)
    AppMailer.notify_on_registration(user).deliver
  end
end