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

  it "creates a current list after the user is created" do
    @user.current_list.should_not be_nil
  end

  it "creates a master list after the user is created" do
    @user.master_list.should_not be nil
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
