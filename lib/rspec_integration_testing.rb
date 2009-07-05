require "rspec_integration_testing/story_example_group_methods"

begin
  require "spec/rails"
rescue LoadError
  raise "RSpec-Rails not available. Install it with sudo gem install rspec-rails"
end

require "rspec_integration_testing/rails_story_example_group"

