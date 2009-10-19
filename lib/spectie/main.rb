module Spectie
  module Main
    # Creates an example group for the feature.
    #   Feature "User Authentication" do
    #     Scenario "As a user without an account, I want to create one so that I can log in" do
    #       Given :i_do_not_have_an_account
    #       And   :i_want_to_log_in
    #
    #       When  :i_create_an_account
    #
    #       Then  :i_can_log_in
    #     end
    #
    #     def i_do_not_have_an_account
    #       # ... codey code ...
    #     end
    #
    #     # ... remaining scenario statements ...
    #   end
    def Feature(*args, &block)
      describe(*args, &block)
    end
  end
end

include Spectie::Main
