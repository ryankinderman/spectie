begin
  require 'spec/rake/spectask'
rescue LoadError
  puts "RSpec not available. Install it with: sudo gem install rspec"
end

namespace :spec do
  Spec::Rake::SpecTask.new(:core) do |spec|
  #    spec.libs << 'lib'
    spec.spec_files = ['spec/rspec_integration_testing_spec.rb', 'spec/rspec_integration_testing/story_example_group_methods_spec.rb']
  end

  Spec::Rake::SpecTask.new(:rails) do |spec|
  #    spec.libs << 'lib'
    spec.spec_files = ['spec/rspec_integration_testing/rails_story_example_group_spec.rb']
  end

  Spec::Rake::SpecTask.new(:selenium) do |spec|
  #    spec.libs << 'lib'
    spec.spec_files = ['spec/rspec_integration_testing/selenium_story_example_group_spec.rb']
  end

#  Spec::Rake::SpecTask.new(:rcov) do |spec|
#  #    spec.libs << 'lib'
#    spec.pattern = 'spec/**/*_spec.rb'
#    spec.rcov = true
#  end
end

task :default => ["spec:core", "spec:rails", "spec:selenium"]
