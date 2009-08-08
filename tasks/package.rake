begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rspec_integration_testing"
    gem.summary = %Q{TODO}
    gem.email = "ryan@kinderman.net"
    gem.homepage = "http://github.com/ryankinderman/rspec_integration_testing"
    gem.authors = ["Ryan Kinderman"]
    gem.rubyforge_project = "rspec_integration_testing"

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

