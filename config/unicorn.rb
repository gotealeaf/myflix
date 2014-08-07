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
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

The above assumes a standard Rails app with ActiveRecord and New Relic for monitoring. For information on other available configuration operations, see Unicorn’s documentation.
Unicorn worker processes

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)

Unicorn forks multiple OS processes within each dyno to allow a Rails app to support multiple concurrent requests without requiring them to be thread-safe. In Unicorn terminology these are referred to as worker processes not to be confused with Heroku worker processes which run in their own dynos.

Each forked OS process consumes additional memory. This limits how many processes you can run in a single dyno. With a typical Rails memory footprint, you can expect to run 2-4 Unicorn worker processes. Your application may allow for more or less processes depending on your specific memory footprint, and we recommend specifying this number in an config var to allow for faster application tuning. Monitor your application logs for R14 errors (memory quota exceeded) via one of our logging addons or heroku logs.
Preload app

preload_app true
# ...
before_fork do |server, worker|
  # ...
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  # ...
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
