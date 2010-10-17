require 'spec_helper'

describe TasksController do

    before(:each) do
      @current_user = Factory(:user)
      sign_in @current_user
      controller.stub(:current_user){ @current_user}
    end

  describe "GET 'index'" do

    before(:each) do
      @tasks = [] 
      7.times{@tasks << Factory(:task, :user => @current_user)}
      
      controller.current_user.stub(:tasks){@tasks}
    end

    it "should find all of the current user's tasks" do
      @current_user.should_receive(:tasks).and_return(@tasks)
      get :index
    end

    it "should assign all the users tasks to the view" do
      get :index
      assigns(:tasks).should == @tasks
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @task = Factory(:task, :user => @current_user)
    end

    it "should create a new task based on the params that were received" do
      @current_user.stub_chain(:tasks, :new).and_return(@task)
      post :create, :task => @task
    end

    context "when the task saves sucessfully" do
      before(:each) do
        current_user.stub_chain(:tasks, :save).and_return(true)
      end

      it "should render the object in json" do
        expected_response = @task.to_json
        post :create, :task => @task
        debugger
        response.body
      end
    end
  end
end
