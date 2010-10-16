require "spec_helper"

describe PagesController do
  describe "routing" do
    it "recognizes and generates #home" do
      { :get => "/pages/home" }.should route_to(:controller => "pages", :action => "home")
    end

    it "routes the root route to pages#home" do
      { :get => '/' }.should route_to(:controller => "pages", :action => "home")
    end
  end
end
