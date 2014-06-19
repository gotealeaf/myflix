class AppMailer < ActionMailer::Base

  def mail_to_leader_when_followed(leader, follower)
    @follower = follower
    mail from: 'info@myflix.com', to: leader.email, subject: "You have a new follower"
  end
end