require File.expand_path(File.dirname(__FILE__) + "/rails_app")

describe "User Registration" do

  scenario "As an unregistered user, I want to create an account so that I can log into the site" do
    Given :i_am_not_logged_in
    When  :i_register_an_account
    Then  :i_can_log_in
  end

  dsl do
    def i_am_not_logged_in
      get root_path
      response.should be_success
      response.should have_tag("a[href=#{new_user_path}]")
    end

    def i_register_an_account
      get new_user_path
      response.should be_success

      post users_path, :user => {
        :email_address => (@email_address = "joe@blow.com"),
        :password => (@password = "secret")
      }
      response.should redirect_to(root_path)
      follow_redirect!
      response.should be_success
    end

    def i_can_log_in
      response.should have_tag("a[href=#{new_session_path}]")
      get new_session_path
      response.should be_success

      post session_path, :session => { :email_address => @email_address, :password => @password }
      response.should redirect_to(root_path)
      follow_redirect!
      response.should match(/#{@email_address}/)
    end
  end

end
