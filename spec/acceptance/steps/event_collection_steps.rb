module EventCollectionSteps
  step "a remote client sends an event of type :type and email type :email_type" do |type, email_type|
    pending
  end
end

RSpec.configure do |config|
  config.include EventCollectionSteps
end
