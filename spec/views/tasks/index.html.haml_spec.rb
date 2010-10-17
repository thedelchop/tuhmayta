require 'spec_helper'

describe "tasks/index.html.haml" do

  before(:each) do
    @current_user = Factory(:user)
    sign_in @current_user

    @tasks = [] 
    7.times{@tasks << Factory(:task, :user => @current_user)}
    
    @example_task = Factory(:task, :name => "example-task", :user => @current_user)
  end

  # it "should display a <li> in the master list for each of the user's uncompleted tasks" do
  #   render

  #   within "#sortable1" do
  #     rendered.should have_selector(:li, :count => 7)
  #   end
  # end

  # it "should display the name of the task within its own <li>" do

  #   render
  #   within("task-#{@example_task.id}") do |scope|
  #     scope.should contain( @example_task.name)
  #   end
  # end

  # it "should display one green tomato for every estimated pomodoro" do
  #   @example_tasks.estimate = 4
  #   render
  #   within("task-#{@example_task.id}") do |scope|
  #     scope.should have_selector( ".estimated-pomodoros", :count => 4)
  #   end
  # end
end
