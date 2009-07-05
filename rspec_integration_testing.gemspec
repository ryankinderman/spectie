# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rspec_integration_testing}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Kinderman"]
  s.date = %q{2009-07-04}
  s.email = %q{ryan@kinderman.net}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "COPYING",
     "COPYING.LESSER",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "examples/simple.rb",
     "initialize.rb",
     "lib/rspec_integration_testing.rb",
     "lib/rspec_integration_testing/rails_story_example_group.rb",
     "lib/rspec_integration_testing/story_example_group_methods.rb",
     "rspec_integration_testing.gemspec",
     "script/spec",
     "spec/example_run_state_tracking.rb",
     "spec/rails_app/README",
     "spec/rails_app/Rakefile",
     "spec/rails_app/app/controllers/application_controller.rb",
     "spec/rails_app/app/helpers/application_helper.rb",
     "spec/rails_app/config/boot.rb",
     "spec/rails_app/config/database.yml",
     "spec/rails_app/config/environment.rb",
     "spec/rails_app/config/environments/development.rb",
     "spec/rails_app/config/environments/production.rb",
     "spec/rails_app/config/environments/test.rb",
     "spec/rails_app/config/initializers/backtrace_silencers.rb",
     "spec/rails_app/config/initializers/inflections.rb",
     "spec/rails_app/config/initializers/mime_types.rb",
     "spec/rails_app/config/initializers/new_rails_defaults.rb",
     "spec/rails_app/config/initializers/session_store.rb",
     "spec/rails_app/config/locales/en.yml",
     "spec/rails_app/config/routes.rb",
     "spec/rails_app/db/.gitignore",
     "spec/rails_app/doc/README_FOR_APP",
     "spec/rails_app/log/.gitignore",
     "spec/rails_app/public/404.html",
     "spec/rails_app/public/422.html",
     "spec/rails_app/public/500.html",
     "spec/rails_app/public/favicon.ico",
     "spec/rails_app/public/images/rails.png",
     "spec/rails_app/public/index.html",
     "spec/rails_app/public/javascripts/.gitignore",
     "spec/rails_app/public/robots.txt",
     "spec/rails_app/script/about",
     "spec/rails_app/script/console",
     "spec/rails_app/script/dbconsole",
     "spec/rails_app/script/destroy",
     "spec/rails_app/script/generate",
     "spec/rails_app/script/performance/benchmarker",
     "spec/rails_app/script/performance/profiler",
     "spec/rails_app/script/plugin",
     "spec/rails_app/script/runner",
     "spec/rails_app/script/server",
     "spec/rails_app/test/performance/browsing_test.rb",
     "spec/rails_app/test/test_helper.rb",
     "spec/rails_app/vendor/.gitignore",
     "spec/rails_env.rb",
     "spec/rspec_integration_testing/rails_story_example_group_spec.rb",
     "spec/rspec_integration_testing/story_example_group_methods_spec.rb",
     "spec/rspec_integration_testing_spec.rb",
     "spec/spec_helper.rb",
     "vendor/.gitignore"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/ryankinderman/rspec_integration_testing}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rspec_integration_testing}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "spec/example_run_state_tracking.rb",
     "spec/rails_env.rb",
     "spec/rspec_integration_testing/rails_story_example_group_spec.rb",
     "spec/rspec_integration_testing/story_example_group_methods_spec.rb",
     "spec/rspec_integration_testing_spec.rb",
     "spec/spec_helper.rb",
     "examples/simple.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
