RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.warn_about_potential_false_positives                 = false
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples    = 0
  config.order               = :random

  # Allow unprefixed RSpec commands (RSpec.describe vs. describe)
  config.expose_dsl_globally = true

  config.warnings = false

  Kernel.srand config.seed
end
