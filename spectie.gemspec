# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{spectie}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Kinderman"]
  s.date = %q{2009-10-19}
  s.description = %q{        Spectie (rhymes with "necktie") is a pure Ruby acceptance testing framework for RSpec. 
        The philosophy of Spectie is that, since the business stakeholders on most projects
        don't care about exactly how you test, you're free to write the acceptance tests on
        a project how *you*, the developer, need to in order to ensure that the implementation
        is correct, easily understood, and maintainable. Furthermore, since you're a developer, 
        the easiest, most straight-forward and maintainable way for you to write your tests is
        by using the highly expressive language that you're already coding in for the project;
        that's Ruby, baby!
}
  s.email = %q{ryan@kinderman.net}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "initialize.rb",
     "lib/spectie.rb",
     "lib/spectie/configuration.rb",
     "lib/spectie/main.rb",
     "lib/spectie/rails.rb",
     "lib/spectie/rails_story_example_group.rb",
     "lib/spectie/selenium.rb",
     "lib/spectie/selenium/configuration.rb",
     "lib/spectie/selenium/story_example_group.rb",
     "lib/spectie/story_example_group_methods.rb",
     "rake_tasks/package.rake",
     "rake_tasks/publish.rake",
     "rake_tasks/spec.rake",
     "rake_tasks/utility.rake",
     "rdoc/classes/Spectie.html",
     "rdoc/classes/Spectie/Configuration.html",
     "rdoc/classes/Spectie/Configuration/ForScenarios.html",
     "rdoc/classes/Spectie/Configuration/Selenium.html",
     "rdoc/classes/Spectie/Main.html",
     "rdoc/classes/Spectie/RailsStoryExampleGroup.html",
     "rdoc/classes/Spectie/SeleniumStoryExampleGroup.html",
     "rdoc/classes/Spectie/StoryExampleGroupMethods.html",
     "rdoc/created.rid",
     "rdoc/files/README_rdoc.html",
     "rdoc/files/lib/spectie/configuration_rb.html",
     "rdoc/files/lib/spectie/main_rb.html",
     "rdoc/files/lib/spectie/rails_rb.html",
     "rdoc/files/lib/spectie/rails_story_example_group_rb.html",
     "rdoc/files/lib/spectie/selenium/configuration_rb.html",
     "rdoc/files/lib/spectie/selenium/story_example_group_rb.html",
     "rdoc/files/lib/spectie/selenium_rb.html",
     "rdoc/files/lib/spectie/story_example_group_methods_rb.html",
     "rdoc/files/lib/spectie_rb.html",
     "rdoc/fr_class_index.html",
     "rdoc/fr_file_index.html",
     "rdoc/fr_method_index.html",
     "rdoc/index.html",
     "rdoc/rdoc-style.css",
     "script/selenium_webapp",
     "script/spec",
     "spec/example_run_state_tracking.rb",
     "spec/selenium_config.rb",
     "spec/spec_helper.rb",
     "spec/spectie/rails_helper.rb",
     "spec/spectie/rails_story_example_group_spec.rb",
     "spec/spectie/selenium/configuration_spec.rb",
     "spec/spectie/selenium/spec_helper.rb",
     "spec/spectie/selenium/story_example_group_spec.rb",
     "spec/spectie/spec_helper.rb",
     "spec/spectie/story_example_group_methods_spec.rb",
     "spec/spectie_spec.rb",
     "spec/support/rails_app/controllers/application_controller.rb",
     "spectie.gemspec",
     "tags"
  ]
  s.homepage = %q{http://github.com/ryankinderman/spectie}
  s.rdoc_options = ["--charset=UTF-8 --ri-site"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubyforge_project = %q{kinderman}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A Ruby integration testing framework written on top of RSpec.}
  s.test_files = [
    "spec/spectie/rails_story_example_group_spec.rb",
     "spec/spectie/selenium/configuration_spec.rb",
     "spec/spectie/selenium/story_example_group_spec.rb",
     "spec/spectie/story_example_group_methods_spec.rb",
     "spec/spectie_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, [">= 1.2.7"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.7"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.7"])
  end
end
