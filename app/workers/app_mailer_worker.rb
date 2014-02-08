class AppMailerWorker

  include Sidekiq::Worker

  def perform(user_id)
    @user = User.find(user_id)
    AppMailer.welcome_email(@user).deliver
  end
end

# sidekiq_options retry: false, queue: "mail"
 
# example
# command =  AppMailerWorker.perform_async(@input_id)

  # def perform(input_id)
  #   code(input_id)
  # end

  #first start redis with redis-server /usr/local/etc/redis.conf  
# don't forget to run it bundle exec sidekiq

# bump pool size in environmnets 
# using the queue set it when starting the server with -q
  # bundle exec sidekiq -q high,5 mail,3, default,1 

#to check if redis is srunning  redis-cli ping   if you get pong it is.
#shut it down with redis-cli shutdown