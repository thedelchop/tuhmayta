require 'spec_helper'

describe TasksController do

  before(:all) do
    @current_user = Factory(:user)
    @task = Factory(:task, :user => @current_user)
  end

  before(:each) do
    sign_in @current_user
    controller.stub(:current_user){ @current_user}
  end
  
  describe "POST 'create'" do
    before(:each) do
      @current_user.stub_chain(:tasks, :new).and_return(@task)
    end

    it "should create a new task based on the params that were received" do
      @current_user.tasks.should_receive(:new).and_return(@task)
      post :create, :task => @task
    end

    context "when the task saves sucessfully" do
      before(:each) do
       @task.stub(:save).and_return(true)
      end

      it "should render the object in json" do
        expected_response = {:task => {:name => @task.name, :id => @task.id, :estimate => @task.estimate}, :notice => "Task added successfully", :success => "true"}.to_json
        post :create, :task => @task
        ActiveSupport::JSON.decode(response.body).should == ActiveSupport::JSON.decode(expected_response)
      end
    end

    context "when the tasks doesn't save sucessfully" do
      before(:each) do
        @task.stub(:save).and_return(false)
        @task.stub(:errors).and_return({:name => "can't be blank"})
      end

      it "should render json for the client that includes the error" do
        expected_response = {:errors => {:name => "can't be blank"}, :success => "false", :notice => "There were problems saving the task"}.to_json
        post :create, :task => @task
        ActiveSupport::JSON.decode(response.body).should == ActiveSupport::JSON.decode(expected_response)
      end
    end
  end

  describe "DELETE 'destroy'" do

    it "finds the task that is going to be deleted" do
      @current_user.tasks.should_receive(:find).and_return(@task)
      delete :destroy, :id => @task.id
    end
    
    context "when the task is found successfully" do

      before(:each) do
        @current_user.stub_chain(:tasks, :find).and_return(@task)
      end
      
      it "deletes the task" do
        @task.should_receive(:destroy)
        delete :destroy, :id => @task.id
      end

      it "sets the response[:success] status to true" do
        expected_response = {:success => "true", :notice => "The task was successfully deleted"}.to_json
        delete :destroy, :id => @task.id
        ActiveSupport::JSON.decode(response.body).should == ActiveSupport::JSON.decode(expected_response)
      end
    end

    context "when the task cannot be found" do
      before(:each) do
        @current_user.stub_chain(:tasks, :find).and_raise(ActiveRecord::RecordNotFound)
      end

      it "sets the response[:success] status to false" do
      expected_response = {:success => "false", :notice => "The task couldn't be deleted, there has been an error"}.to_json
      delete :destroy, :id => @task.id
      ActiveSupport::JSON.decode(response.body).should == ActiveSupport::JSON.decode(expected_response)
      end
    end
  end
end
