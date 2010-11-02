@selenium
Feature: Add tasks to current task list from master task list

  Background:
    Given I am a registered Tuhmayta user with the email, "TestMan@example.com"
      And I have the following tasks:
          | name        |  estimate | completed   |    tags    |
          | Test Task 1 |     3     |     1       | hard, bad  |
          | Test Task 2 |     2     |     0       | easy, fun  | 
          | Test Task 3 |     3     |     0       | tough, bad |
          | Test Task 4 |     1     |     0       | tough, fun |
          | Test Task 5 |     4     |     0       | easy, bad  |
          | Test Task 6 |     5     |     0       | hard, fun  |
      And my day consists of 8 pomodoros
      And I sign in
    
  Scenario: View current tasks for today 
    When I activate the "Today" tab
    Then I should see "Test Task 1"
     And I should see "Test Task 2"
     And I should see "Test Task 3"
     And I should see "Test Task 4"
     But I should not see "Test Task 5"




