require 'spec_helper'

describe ListTask do

  before(:each) do
    @list_task = Factory(:list_task)
  end

  it "requires a task" do
    @list_task.task = nil
    @list_task.should_not be_valid
  end

  it "requires a list" do
    @list_task.list = nil
    @list_task.should_not be_valid
  end

  it "requires a position" do
    @list_task.position = nil
    @list_task.should_not be_valid
  end

  it "requies that the task be unique within the scope of a list" do
    @duplicate_list_task = Factory.build(:list_task, :list => @list_task.list, :task => @list_task.task)
    @duplicate_list_task.should_not be_valid
  end

  it "permits duplicate tasks across lists" do
    @same_task_different_list = Factory(:list_task, :task => @list_task.task, :list => Factory(:list, :user => @list_task.task.user, :name => "A different list"))
    @same_task_different_list.should be_valid
  end

  it "requires that a list_task position be unique to a list" do
    @new_task = Factory(:task, :user => Factory(:user, :email => "TestGirl@example.com"))
    @second_list_task = Factory.build(:list_task, :list => @list_task.list, :task => @new_task, :position => @list_task.position)
    @second_list_task.should_not be_valid
  end
end
  
