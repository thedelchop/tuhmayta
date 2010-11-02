require 'spec_helper'

describe Settings do
  
  before(:each) do
    # @user = mock('user')
    @user = Factory.stub(:user)
    @settings = Settings.create(:user_id => @user.id)
  
  end

  it "should be valid with valid attributes" do
    @settings.should be_valid
  end

  it "should belong to a user" do
    @settings.user = nil
    @settings.should_not be_valid
  end

  it "the user should be unique" do
    @second_settings = Factory.build(:settings, :user => @settings.user)
    @second_settings.should_not be_valid
  end

  it "defaults the pomodoro time to 25 minutes" do
    @settings.pomodoro_time.should == 25
  end

  it "defaults the rest time to 5 minutes" do
    @settings.rest_time.should == 5
  end

  it "defaults the number of pomodors before a long rest to 4" do
    @settings.long_rest_interval.should == 4
  end

  it "defaults the length of a day to 12 pomodoros" do
    @settings.day_length.should == 12
  end
end
