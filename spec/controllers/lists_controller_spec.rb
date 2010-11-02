require 'spec_helper'

describe ListsController do

  before(:all) do
    @current_user = Factory(:user)
    @list = Factory(:list, :user => @current_user)
  end
    
  before(:each) do
    controller.stub(:current_user){@current_user}
    @current_user.stub(:current_list).and_return(@list)  
    @current_user.stub(:master_list).and_return(@list)  
    sign_in @current_user
  end

  after(:each) do
    sign_out @current_user
  end

  describe "GET 'show'" do
    
    it "sorts the list's tasks by position" do
      @list.list_tasks.should_receive(:sort!)
      get :show, :id => @current_user.master_list.id
    end

    it "assigns the list to the view for rendering" do
      get :show, :id => @current_user.master_list.id
      assigns[:list].should == @list
    end
    
    context "when the request is for the master list" do

      it "returns a reference to the master list" do
        @current_user.should_receive(:master_list)
        get :show, :id => @current_user.master_list.id
      end  
    end
    
    context "when the request is for the current list" do

      it "returns a reference to the current list" do
        @current_user.should_receive(:current_list)
        get :show, :id => @current_user.current_list.id
      end  
    end
  end
end


