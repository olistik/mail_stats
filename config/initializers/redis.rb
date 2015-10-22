$redis = ConnectionPool.new(size: 10, timeout: 5) { Redis.new }
