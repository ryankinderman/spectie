namespace :package do
  begin
    require 'jeweler'
    Jeweler::Tasks.new do |gem|
      gem.name = %q{spectie}
      gem.summary = %q{A Ruby integration testing framework written on top of RSpec.}
      gem.description = <<-EOF
        Spectie (rhymes with "necktie") is a pure Ruby acceptance testing framework for RSpec. 
        The philosophy of Spectie is that, since the business stakeholders on most projects
        don't care about exactly how you test, you're free to write the acceptance tests on
        a project how *you*, the developer, need to in order to ensure that the implementation
        is correct, easily understood, and maintainable. Furthermore, since you're a developer, 
        the easiest, most straight-forward and maintainable way for you to write your tests is
        by using the highly expressive language that you're already coding in for the project;
        that's Ruby, baby!
      EOF
      gem.platform = Gem::Platform::RUBY
      gem.required_ruby_version = '>= 1.8.6'
      gem.add_dependency('rspec', '>= 1.2.7')

      gem.authors = ["Ryan Kinderman"]
      gem.date = Time.now.strftime("%Y-%m-%d")
      gem.email = %q{ryan@kinderman.net}
      gem.homepage = %q{http://github.com/ryankinderman/spectie}
      gem.rubyforge_project = %q{kinderman}

      gem.has_rdoc = true
      gem.rdoc_options = ["--charset=UTF-8"]
      gem.extra_rdoc_files = [
        "LICENSE",
        "README.rdoc"
      ]

      gem.require_paths = ["lib"]
      gem.files = Dir["**/*"] 
      gem.files.reject! { |f| !f.match(/^(vendor|pkg)(\/|$)/).nil? }
      gem.test_files = Dir["spec/**/*_spec.rb"]

      # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    end

    Jeweler::RubyforgeTasks.new do |rubyforge|
      rubyforge.doc_task = "rdoc"
    end

    Jeweler::GemcutterTasks.new
  rescue LoadError
    puts "Jeweler not available. It's only needed if you're going to build the gem for this library. Install it with something like: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
  end

  desc "Cleans the project package artifacts, generates all files needed to build the gem, and builds it"
  task :full => ["clean", "rdoc", "gemspec", "build"]

  namespace :release do
    desc "Do the full packaging of the gem and release it everywhere"
    task :full => ["package:full", "package:rubyforge:release", "package:gemcutter:release"] do
      
    end
  end
end
