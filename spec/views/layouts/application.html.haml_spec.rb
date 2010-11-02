require "spec/spec_helper"

describe "layouts/application.html.haml" do

  before(:each) do
    @user = Factory(:user)
    sign_out @user
  end

  describe "should display a navigation menu for the user" do

    context "when the user hasn't yet signed in" do

      it "with the link to sign up for an account" do
        render
        rendered.should have_selector(:a, :content => "Sign Up")
      end 

      it "with the link to sign in to an existing account" do
        render
        rendered.should have_selector(:a, :content => "Sign In")
      end

      it "with a link to the about page" do
        render
        rendered.should have_selector(:a, :content => "About") do

        end
      end
    end

    context "when the user is signed in" do
      
      it "with the link to log out of your account" do
        sign_in @user
        render
        rendered.should have_selector(:a, :content => "Sign Out")
      end

      it "with a link to change to widget mode" do
        sign_in @user
        render
        rendered.should have_selector(:a, :content => "Show Dashboard") 
      end

      it "with a link to view your account's settings" do
        sign_in @user
        render
        rendered.should have_selector(:a, :content => "Settings")
      end

      it "with a link to view the help for Tuhmayta"do
        sign_in @user
        render
        rendered.should have_selector(:a, :content => "Help")
      end
    end
  end
end
