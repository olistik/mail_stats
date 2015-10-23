ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'shoulda/matchers'
require 'shoulda/matchers/integrations/rspec'

# Load support files
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/shared/**/*.rb")].each  { |f| require f }

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
end
