begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "spectie"
    gem.summary = %Q{TODO}
    gem.email = "ryan@kinderman.net"
    gem.homepage = "http://github.com/ryankinderman/spectie"
    gem.authors = ["Ryan Kinderman"]
    gem.rubyforge_project = "spectie"

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

