require 'spec_helper'

describe List do

  before(:each) do
    @user = Factory.stub(:user)
    User.stub(:find).and_return(@user)
    @list = Factory(:list, :user => @user)
    Task.stub(:append_to_master_list).and_return(nil) 
  end
  it "is valid with valid attributes" do
    @list.should be_valid
  end

  it "requires a name for the list" do
    @list.name = nil
    @list.should_not be_valid
  end

  it "requires a user to own the list" do
    @list.user_id = nil
    @list.should_not be_valid
  end

  it "requires that the name be unique within the scope of the user who owns it" do
    @second_list = Factory.build(:list, :name => @list.name, :user => @list.user)
    @second_list.should_not be_valid 
  end

  it "premits duplicate list names across mutiple users" do
    @second_list = Factory.build(:list, :name => @list.name, :user => Factory(:user, :email => "SecondUser@example.com"))

    @second_list.should be_valid
  end

  describe "#to_param" do
    
    it "returns the name of the list" do
      @list.to_param.should == @list.name
    end
  end

  describe "#expired?" do
    before(:all) do
      DAY_IN_SECS = 86400
    end

    context "when the list is more than 24 hours old" do
      before(:each)  do
        @list.stub(:updated_at).and_return(Time.now.utc - DAY_IN_SECS - 1)
      end
      
      it "returns true" do
        @list.expired?.should == true 
      end
    end

    context "when the list is less than 24 hours old" do
      before(:each) do
        @list.stub(:updated_at).and_return(Time.now.utc - 1)
      end

      it "returns nil" do
        @list.expired?.should == false
      end
    end
  end


  describe "#tasks" do
    it "returns all of the tasks associated with this list, sorted by their posistion in the list" do
      @list.list_tasks =  [4,2,1,3].each {|position| Factory(:list_task, :list => @list, :task => Factory(:task, :user => @list.user), :position => position)}
      @list.tasks.should == [ListTask.where(:position => 1).first.task, ListTask.where(:position => 2).first.task,ListTask.where(:position => 3).first.task, ListTask.where(:position => 4).first,task]
    end
  end
end
