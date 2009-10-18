module Spectie
  module Main
    def Feature(*args, &block)
      describe(*args, &block)
    end
  end
end

include Spectie::Main
