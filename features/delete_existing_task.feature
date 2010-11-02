@selenium
Feature: Delete existing task

  Background:
    Given I am a registered Tuhmayta user with the email, "TestMan@example.com"
      And I have the following tasks:
          | name        |  estimate |  tags       |
          | Test Task 1 |     3     |  hard, bad  |
          | Test Task 2 |     2     |  easy, fun  | 
      And I sign in

    Scenario: Delete a Task
      When I press "Delete" for "Test Task 1"
      Then I should not see "Test Task 1" in my master list of tasks



