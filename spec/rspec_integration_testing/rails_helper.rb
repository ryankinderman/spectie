require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

Dir[File.expand_path(File.dirname(__FILE__) + "/../../vendor/rails/*/lib")].each do |rails_lib|
  $:.unshift rails_lib
end

ENV["RAILS_ENV"] = "test"
$:.unshift File.expand_path(File.dirname(__FILE__) + "/../support/rails_app/controllers")

require "initializer"
require "action_controller"

ActionController::Base.session = {:key => "_myapp_session", :secret => "a"*30}
