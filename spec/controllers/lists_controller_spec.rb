require 'spec_helper'

describe ListsController do
    
  before(:each) do
    @current_user = Factory(:user)
    sign_in @current_user
    controller.stub(:current_user){@current_user}
    @list = Factory(:list)
  end

  describe "GET 'index'" do

    context "when the request is for the master list" do

      it "returns a reference to the master list" do
        @current_user.stub(:master_list).and_return(@list)  
        get :index, :type => "master"
        debugger
        @current_user.should_receive(:master_list)
      end  
    end
    
    context "when the request is for the current list" do

      it "returns a reference to the current list" do
        @current_user.stub(:current_list).and_return(@list)  
        get :index, :type => "current"
        @current_user.should_receive(:current_list)
      end  
    end
      
    it "sorts the list by poistion" do
      @list.should_receive(:order).with(:position)
    end

    it "assigns the list to the view for rendering" do
      assigns[:list].should == @list
    end
  end
end


