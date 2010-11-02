@selenium
Feature: Add new task
  So that I may finish all of the work I need to do
  As a Tuhmayta user
  I want to be able to add new tasks to my pomodoro

  Background:
    Given I am a registered Tuhmayta user with the email, "TestMan@example.com"
      And I sign in

  Scenario: Add New Task
      And I enter "Test Task" for the task name
      And I estimate this task will take 4 Pomodoros
      And I tag this task with "test, these, tags"
     When I press "Add Task"
     Then I should see "Test Task" in my master list of tasks
      And I should see "Task added successfully"

  Scenario: Attempt to add new task without name
      And I estimate this task will take 4 Pomodoros
      And I tag this task with "test, these, tags"
     When I press "Add Task"
     Then I should see "There were problems saving the task"
     
