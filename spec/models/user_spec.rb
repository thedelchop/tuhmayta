require 'spec_helper'

describe User do
  before(:each) do
    @user = Factory(:user)
  end

  it "is valid with valid attributes" do
    @user.should be_valid
  end

  it "requires a email address" do
    @user.email = nil
    @user.should_not be_valid
  end

  it "requires a unique email address" do
    @copy_user = Factory.build(:user, :email => @user.email)
    @copy_user.should_not be_valid
  end

  it "requires that its a valid email address" do
    @user.email = "Test"
    @user.should_not be_valid
  end

  it "requires a password" do
    @new_user = Factory.build(:user, :password => nil)
    @new_user.should_not be_valid
  end

  it "requires that the password be at least 6 characters long" do
    @user.password = "short"
    @user.should_not be_valid
  end

  it "creates a master list after the user is created" do
    @user.master_list.should_not be_nil
  end

  it "creates a settings instance for the user after creation" do
    @user.settings.should_not be_nil
  end

  describe "#current_list" do
    before do

      @current_list = List.where(:user_id => @user.id, :name => "current").first
      @master_list = List.where(:user_id => @user.id, :name => "master").first
      
      5.times{ @current_list.list_tasks << Factory(:list_task, :list => @current_list, :task => Factory(:task, :user => @user))}
      5.times{ @master_list.list_tasks << Factory(:list_task, :list => @master_list, :task => Factory(:task, :user => @user))}
      
      List.stub_chain(:where, :first).and_return(@current_list)  
    end

    it "finds the user's current list" do
      List.should_receive(:where)
      @user.current_list
    end

    context "when the current list has expired" do
      before(:each) do
        @current_list.stub(:expired?).and_return(true)
        @current_list.stub_chain(:list_tasks,:destroy).and_return(@current_list.list_tasks)
      end

      it "clears the current list of all its tasks" do
        @current_list.list_tasks.should_receive(:destroy)
        @user.current_list
      end

      it "looks up the length of a user's day, in pomodoros" do
        @user.stub_chain(:settings, :day_length)
        @user.settings.should_receive(:day_length)
        @user.current_list 
      end

      it "returns an array of tasks sorted by position from the master list" do
        @user.stub_chain(:master_list, :list_tasks, :order, :collect)
        @user.master_list.list_tasks.order.should_receive(:collect)
        @user.current_list
      end

      context "the master list has no tasks" do
        
        it "returns an empty the list" do
          @tasks = [] 
          @tasks.stub(:nil?).and_return(true)
          @user.current_list.should == @current_list
        end
      end
    end
  end

  describe "#setup_lists" do
    
    before do
      List.stub(:create).with(:name => "current", :user_id => @user.id)
      List.stub(:create).with(:name => "master", :user_id => @user.id)
    end

    it "creates a new master list" do
      List.should_receive(:create).with(:name => "current", :user_id => @user.id)
    end

    it "creates a new current list" do
      List.should_receive(:create).with(:name => "master", :user_id => @user.id)
    end

    after(:each) do
      @user.setup_lists
    end
  end
end
