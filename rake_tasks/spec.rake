begin
  require 'spec/rake/spectask'
rescue LoadError
  puts "RSpec not available. Install it with: sudo gem install rspec"
end

namespace :spec do
  namespace :suite do
    desc ""
    Spec::Rake::SpecTask.new(:core) do |spec|
      spec.spec_files = ['spec/spectie_spec.rb', 'spec/spectie/story_example_group_methods_spec.rb']
    end

    desc ""
    Spec::Rake::SpecTask.new(:rails) do |spec|
      spec.spec_files = ['spec/spectie/rails_story_example_group_spec.rb']
    end

    desc ""
    Spec::Rake::SpecTask.new(:selenium) do |spec|
      spec.spec_files = ['spec/spectie/selenium/**/*_spec.rb']
    end
  end

  (all = [:core, :rails, :selenium]).each do |example_suite|
    desc "Run #{example_suite} example suite"
    task example_suite do
      puts "\nRunning suite: #{example_suite}"
      Rake.application["spec:suite:#{example_suite}".to_sym].invoke
    end
  end

  task :all => all

#  Spec::Rake::SpecTask.new(:rcov) do |spec|
#  #    spec.libs << 'lib'
#    spec.pattern = 'spec/**/*_spec.rb'
#    spec.rcov = true
#  end
end

task :default => ["spec:core", "spec:rails"]
