class ActionController::IntegrationTest
  alias_method :orig_initialize, :initialize
  def initialize(*args)
    super
  end
end

module RspecIntegrationTesting

  class RailsStoryExampleGroup < ActionController::IntegrationTest
    include StoryExampleGroupMethods

#     def reset!
#       session = super
# #      ActionMailer::Base.deliveries.clear
#       session.remote_addr = '208.77.188.166' # example.com
#       session
#     end
  end

end
