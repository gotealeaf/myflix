class MailWorker
  include Sidekiq::Worker

  def perform(invitation)
    AppMailer.send_invitation_email(invitation).deliver
  end
end