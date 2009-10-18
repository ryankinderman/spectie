begin
  require 'spec/rake/spectask'
rescue LoadError
  puts "RSpec not available. Install it with: sudo gem install rspec"
end

namespace :spec do
  namespace :spec_tasks do
    Spec::Rake::SpecTask.new(:core) do |spec|
      spec.spec_files = ['spec/spectie_spec.rb', 'spec/spectie/story_example_group_methods_spec.rb']
    end

    Spec::Rake::SpecTask.new(:rails) do |spec|
      spec.spec_files = ['spec/spectie/rails_story_example_group_spec.rb']
    end

    Spec::Rake::SpecTask.new(:selenium) do |spec|
      spec.spec_files = ['spec/spectie/selenium/**/*_spec.rb']
    end
  end

  (all = [:core, :rails, :selenium]).each do |task_name|
    task task_name do
      puts "\nRunning suite: #{task_name}"
      Rake.application["spec:spec_tasks:#{task_name}".to_sym].invoke
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
