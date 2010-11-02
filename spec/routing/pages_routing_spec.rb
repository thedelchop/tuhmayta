require "spec_helper"

describe PagesController do
  
  describe "routing" do
    it "recognizes and generates #home" do
      { :get => "/pages/home" }.should route_to(:controller => "pages", :action => "home")
    end

    context "when no user is signed in" do
      it "routes the root route to pages#home" do
        RootConstraints.stub!(:matches?).and_return(false)
        { :get => '/' }.should route_to(:controller => "pages", :action => "home")
      end
    end

    context "when a user is already signed in" do
      it "routes the root route to 'lists#show/master" do
        RootConstraints.stub!(:matches?).and_return(true) 
        { :get => '/' }.should route_to(:controller => "lists", :action => "index")
      end
    end
  end
end
