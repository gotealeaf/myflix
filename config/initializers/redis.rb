uri = URI.parse("redis://redistogo:ccb0c860fb54e54e0b8e828d123cf801@grideye.redistogo.com:10204/" || "redis://localhost:6379/" )
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
