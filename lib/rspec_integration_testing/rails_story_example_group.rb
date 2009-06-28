module RspecIntegrationTesting

  class RailsStoryExampleGroup < Spec::Rails::Example::IntegrationExampleGroup
    include StoryExampleGroupMethods

#     def reset!
#       session = super
# #      ActionMailer::Base.deliveries.clear
#       session.remote_addr = '208.77.188.166' # example.com
#       session
#     end
  end

end
