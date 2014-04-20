# config/unicorn.rb

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  #This spawns the new process in unicorn instead of dynoing a new worker
  @sidekiq_pid ||= spawn("bundle exec sidekiq -c 2")
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

  # I think this triggers the config we setup in Heroku for REDIS_URL.
  # Seems like you could still get over nano's 10 connection limit
  # If had (2)Sidekiq's x 5 = 10. Then had (1)Web. Total = 11. Correct?
  # Maybe I'm just not getting this chunk of code...
  Sidekiq.configure_client do |config|
    config.redis = { :size => 1 }
  end
  Sidekiq.configure_server do |config|
    config.redis = { :size => 5 }
  end
end

