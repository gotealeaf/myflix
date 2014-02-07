# uri = URI.parse(ENV["REDISTOGO_URL"])
# REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
ENV["REDISTOGO_URL"] = 'redis://localhost:6379/0'
uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)



# uri = URI.parse(URI.encode(url.strip))