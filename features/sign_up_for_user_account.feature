Feature: Sign up for user account
  In order to take advantage of Tuhmayta's offerings
  As an unregistered user
  I want to be able to create a new user account

  Background:
    Given I am on the homepage
      And I am not signed in 
     When I follow "Sign Up"

  Scenario: Successfully navigate to the Tuhmayta Registration page
     Then I should be on the new account registration page

  Scenario: Successfully register for a Tuhmayta account
      And I fill out the registration form
      When I fill in the following:
        | Email                 | TestMan@example.com |
        | Password              | secret  |
        | Password confirmation | secret  |
      And I press "Sign up"
     Then I should be on the homepage
      And I should see "Sign Out"

  Scenario: Attempt to sign up when Tuhmayta account exists
    Given the user, "TestMan@example.com", already exists
      When I fill in the following:
        | Email                 | TestMan@example.com |
        | Password              | secret  |
        | Password confirmation | secret  |
      And I press "Sign up"
     Then I should be on the new account registration page again
      And I should see "Email has already been taken"
 


