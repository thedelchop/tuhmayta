@wip
Feature: Add Task to ToDo List
  In order to be able to schedule the work that I will do during the upcoming day
  As a Tuhmayta! user
  I want to be able to add one of my tasks to my To-Do list.

  Scenario: Add a task to my To Do List
    Given I am the registered Tuhmayta user, NewUser
      And I login
      And I have a task named "TestTask"
      And I follow "Show Dashboard"
     When I follow "Today"
      And I follow "Add Task"
      And I select "Test Task"
     Then I should be on NewUser's todo list
      And I should see "Test Task"
