module StorageStatusSteps
  step "there is no event collected" do
    $redis.with do |connection|
      connection.flushdb
    end
  end
end

RSpec.configure do |config|
  config.include StorageStatusSteps
end
