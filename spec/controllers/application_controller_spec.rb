require 'spec_helper'

describe ApplicationController do

  describe "#after_sign_in_path_for(:resource)" do

    it "should return the href to the homepage" do
       @user = Factory(:user)
       controller.after_sign_in_path_for(@user).should == root_path
    end
  end

end
