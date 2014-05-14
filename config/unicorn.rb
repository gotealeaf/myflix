worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
preload_app true

if ENV["RAILS_ENV"] == "test"
  timeout 10000
else
  timeout 15
end

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  # hack to avoid paying for worker dyno for a demo app
  # don't do this in production on a real app!
  # from https://coderwall.com/p/fprnhg
  @sidekiq_pid ||= spawn("bundle exec sidekiq -c 2")

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end