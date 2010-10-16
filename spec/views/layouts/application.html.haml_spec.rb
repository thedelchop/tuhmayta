require "spec/spec_helper"

describe "layouts/application.html.haml" do

  before(:each) do
    @user = Factory(:user)
    sign_out @user
  end

  it "should display any flash notices" do
    flash[:notice] = "This is a test notice"
    render
    rendered.should have_selector("div#flash", :content => "This is a test notice")
  end

  it "should display any flash alerts" do
    flash[:alert] = "This is a test alert"
    render
    rendered.should have_selector("div#flash", :content => "This is a test alert")

  end
  
  describe "should display a navigation menu for the user" do

    context "when the user hasn't yet signed in" do

      it "displays the link to sign up for an account" do
        render
        rendered.should have_selector(:a, :content => "Sign Up")
      end 

      it "displays the link to sign in to an existing account" do
        render
        rendered.should have_selector(:a, :content => "Sign In")
      end
    end

    context "when the user is signed in" do
      
      it "displays the link to log out of your account" do
        sign_in @user
        render
        rendered.should have_selector(:a, :content => "Log Out")
      end
    end
  end
end
