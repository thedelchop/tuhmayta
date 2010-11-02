@javascript, @later
Feature: Delete existing task

  Background:
    Given I am a registered Tuhmayta user with the email, "TestMan@example.com"
      And I have the following tasks:
          | name        |  estimate |  tags       |
          | Test Task 1 |     3     |  hard, bad  |
          | Test Task 2 |     2     |  easy, fun  | 
      And I sign in

  Scenario: Edit existing task
     When I press "Edit" for "Test Task 1"
      And I fill in "Test Task Edited" for "Name"
      And I press "Update"
     Then I should see "Test Task Edited" in my master list of tasks
