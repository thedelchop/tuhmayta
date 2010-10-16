@wip
Feature: Manage User Account
  In order to ensure that my personal information is correct
  As a Tuhmayta User
  I want to be able to mange my profile

  Background:
   Given I am the registered Tuhmayta user, NewUser
     And I login
     And I follow "Settings"
  
  Scenario: View User account information
    Then I should be on the settings page
  
  Scenario: Edit User account information
   When I fill in "MrTestMan" for "Username"
    And I fill in "secret" for "Current password"
    And I press "Update"
   Then I should see "You updated your account successfully"
    And I should be on the settings page
    
  Scenario: Update User replace information
    When I fill in "TestMan1@example.com" for "Email"
     And I fill in "secret" for "Current password"
     And I press "Update"
     Then I should be on the settings page
     And the "Email" field should contain "TestMan1@example.com"
