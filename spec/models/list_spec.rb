require 'spec_helper'

describe List do

  before(:each) do
    @list = Factory(:list)
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
end
