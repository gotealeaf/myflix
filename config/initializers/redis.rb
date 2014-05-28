#uri = URI.parse(ENV["REDIS_PROVIDER"])
$redis = Redis.new(:host => 'localhost', :port => 6379)