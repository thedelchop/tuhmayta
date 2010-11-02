Feature: Log Into User Account
  In order to manage my tasks and my account
  As a Tuhmayta user
  I want to be able to log in to my account

Background:
  Given I am a user with the email, "TestMan@example.com"
    And I already have a Tuhmayta account
    And I am on the homepage
    And I follow "Sign In"

  Scenario: Display the Sign In form
   Then I should be on the sign in page

  @selenium
  Scenario: Successfully Sign In
   When I fill in "Email" with "TestMan@example.com" 
    And I fill in "Password" with "secret" 
    And I press "Sign in"
   Then I should be on the homepage
    And the "Tasks" tab should be active
    And I should see "Signed in successfully."

  Scenario: Unsuccessfully Sign In
    When I fill in "Email" with "TestMan@example.com"
     And I press "Sign in"
    Then I should be on the sign in page 
     And I should see "Invalid email or password."

  Scenario: Sucessfully Sign Out
   When I login
   When I logout
   Then I should be on the home page
    And I should see "Signed out successfully."






