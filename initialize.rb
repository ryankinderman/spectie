require 'rubygems'

Dir[File.dirname(__FILE__) + "/vendor/*/lib"].each do |lib|
  $:.unshift File.expand_path(lib)
end
