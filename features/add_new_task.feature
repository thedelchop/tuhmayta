Feature: Add new task
  So that I may finish all of the work I need to do
  As a Tuhmayta user
  I want to be able to add new tasks to my pomodoro

  Scenario: View Add New Task Dialouge
    Given I am a registered Tuhmayta user with the email, "TestMan@example.com"
      And I sign in
      And I enter "Test Task" for the task name
      And I estimate this task will take 4 Pomodoros
      And I tag this task with "test, these, tags"
     When I press "Add Task"
     Then I should see "Test Tasks" within "Task List"
      And I should see "Task added succesfully"

  # Scenario: Add New Task
  #   Given I am the registered Tuhmayta user, NewUser
  #     And I login
  #     And I follow "Show Dashboard"
  #     And I follow "Add New Task"
  #    When I fill in "Test Task" for "Name"
  #     And I select "4" from "Estimated time"
  #     And I press "Add"
  #    Then I should be on NewUser's task list
  #     And I should see "Test Task"
  #    
