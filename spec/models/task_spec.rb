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

end
