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
end
