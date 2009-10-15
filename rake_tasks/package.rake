namespace :package do
  begin
    require 'jeweler'
    Jeweler::Tasks.new do |gem|
      gem.name = %q{spectie}
      gem.summary = %q{A Ruby integration testing framework written on top of RSpec.}
      gem.description = gem.summary + "yea"
      gem.platform = "Gem::Platform::Ruby"
      gem.required_ruby_version = '>= 1.8.6'
      gem.add_dependency('rspec', '>= 1.2.7')

      gem.authors = ["Ryan Kinderman"]
      gem.date = Time.now.strftime("%Y-%m-%d")
      gem.email = %q{ryan@kinderman.net}
      gem.homepage = %q{http://github.com/ryankinderman/spectie}
      gem.rubyforge_project = %q{spectie}

      gem.has_rdoc = true
      gem.rdoc_options = ["--charset=UTF-8"]
      gem.extra_rdoc_files = [
        "LICENSE",
         "README.rdoc"
      ]

      gem.require_paths = ["lib"]
      gem.files = Dir["**/*"] 
      gem.files.reject! { |f| !f.match(/^vendor(\/|$)/).nil? }
      gem.test_files = Dir["spec/**/*_spec.rb"]

      # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    end
  rescue LoadError
    puts "Jeweler not available. It's only needed if you're going to build the gem for this library. Install it with something like: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
  end
end
