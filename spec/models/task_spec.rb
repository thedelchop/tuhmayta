require 'spec_helper'

describe Task do
  before(:each) do
    @task = Factory(:task)
  end

  it "should be valid with valid attributes" do
    @task.should be_valid
  end

  it "is invalid without a name" do
    @task.name = nil
    @task.should_not be_valid
  end

  it "must belong to a user" do
    @task.user = nil
    @task.should_not be_valid
  end

  it "must be given an estimated time of completion" do
    @task.estimate = nil
    @task.should_not be_valid
  end

  it "the estimate cannot be 0" do 
    @task.estimate = 0
    @task.should_not be_valid
  end

  it "the estimate cannot be greater than 5" do
    @task.estimate = 6
    @task.should_not be_valid
  end

  it "defaults to not completed" do
    @task.complete?.should == false
  end

  describe "#append_to_master_list" do

    before do
      @user = @task.user
      ListTask.stub(:create)
    end
    
    it "finds the user that the task belongs to" do
      User.stub(:find).and_return(@user)
      User.should_receive(:find).and_return(@user)
      @task.append_to_master_list
    end

    it "creates a new list task, for the current user's master list and places it at the end of that list" do
      ListTask.should_receive(:create).with(hash_including(:task_id => @task.id, :list_id => @user.master_list.id, :position => @user.master_list.tasks.count + 1))
      @task.append_to_master_list
    end

    context "when the task is urgent" do

      before(:each) do
        @task.urgent = true
      end

      it "should also be appended to the end of the user's current task list also" do
      ListTask.should_receive(:create).with(hash_including(:task_id => @task.id, :list_id => @user.current_list.id, :position => @user.current_list.tasks.count + 1))
      @task.append_to_master_list
      end

    end
  end

  it "deletes all list_tasks that are associated with it upon deletion" do
      @list_task = Factory(:list_task, :task => @task, :list => @task.user.master_list)
      task_id = @task.id
      @task.destroy
      ListTask.find_by_task_id(task_id).should be_nil
  end
end
