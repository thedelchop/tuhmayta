require "spec_helper"

describe TasksController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/tasks" }.should route_to(:controller => "tasks", :action => "index")
    end
  end
end
