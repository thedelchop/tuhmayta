require 'spec_helper'

describe ApplicationController do

  describe "#after_sign_in_path_for(:resource)" do

    it "should return the href for the user's master task list" do
       @user = Factory(:user)
       controller.after_sign_in_path_for(@user).should == tasks_path
    end
  end

end
