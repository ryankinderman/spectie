# Spectie

Spectie (rhymes with "necktie") is a pure Ruby acceptance testing framework for RSpec. 

The philosophy of Spectie is that, since the business stakeholders on most projects
don't care about exactly how you test, you're free to write the acceptance tests on
a project how *you*, the developer, need to in order to ensure that the implementation
is correct, easily understood, and maintainable. Furthermore, since you're a developer, 
the easiest, most straight-forward and maintainable way for you to write your tests is
by using the highly expressive language that you're already coding in for the project;
that's Ruby, baby!

With this philosophy in mind, what Spectie provides is:

* A small number of methods on top of RSpec for making your acceptance tests readable. This isn't much more than "Given/When/Then".
* A configuration and mapping layer for different integration testing code, such as what's provided by ActionController's integration.rb, or the Ruby client for Selenium.
* Common functionality for supported integration testing solutions, such as the option to restart the Selenium browser between tests, or simply clear the cookies.

Advantages of having your acceptance tests written with Spectie:

* It's Ruby.
* If you're familiar with RSpec already, all the same functionality is available.
* All new syntax beyond RSpec is strictly optional.
* Use familiar methods for code navigation and reuse.
* Start simple, have everything in one place, and break common functionality into separate files when you're ready, and _not_ as a rule.

## Example

    describe "Compelling Feature" do
      scenario "As a user, I would like to use a compelling feature" do
        Given :i_have_an_account
        And   :i_have_logged_in

        When  :i_access_a_compelling_feature

        Then  :i_am_presented_with_stunning_results
      end

      def i_have_an_account
        @user = create_user
      end

      def i_have_logged_in
        log_in_as @user
      end

      def i_access_a_compelling_feature
        get compelling_feature_path
        response.should be_successful
      end 

      def i_am_presented_with_stunning_results
        response.should have_text("Simply stunning!")
      end
    end

## Installation

### Gem
    sudo gem install spectie

### Rails plugin
    script/plugin install git://github.com/ryankinderman/spectie.git 

### Git
    git clone git://github.com/ryankinderman/spectie.git

## Configuration
### Ruby on Rails
### Selenium

## Author

Ryan Kinderman

ryan@kinderman.net

## Copyright

Copyright (c) 2009 Ryan Kinderman. See LICENSE for details.
