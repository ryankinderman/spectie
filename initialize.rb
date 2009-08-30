require 'rubygems'

Dir[File.dirname(__FILE__) + "/vendor/*/lib"].each do |lib|
  lib_path = File.expand_path(lib)
  $:.unshift lib_path unless $:.include?(lib_path)
end
