require 'spec/spec_helper'

describe "lists/index.html.haml" do

  before(:each) do
    @current_user = Factory(:user)
    @tasks = [] 
    7.times{@tasks << Factory(:task, :user => @current_user)}
    sign_in @current_user
  end

  describe "rendering the add new task form" do

    it "should render a form for adding new tasks" do
      render
      rendered.should have_selector(:form, :id => "new-task-form")
    end

    it "should render an input for the name of a test" do
      render 
      rendered.should have_selector(:input, :type => "text", :id => "task-name")
    end

    it "should render a select box for the estimated # of pomodoros" do
      render
      rendered.should have_selector(:select, :id => "task_estimate")
    end

    it "should render a text field to input any tags for the task" do
      render
      rendered.should have_selector(:input, :type => "text", :id => "task-tags")
    end

    it "should render a submit button, with the title 'Add Task'" do
      render
      rendered.should have_selector(:input, :type => "submit", :value => "Add Task")
    end
  end

  describe "rendering the tabs for the master and current tasks" do
    
    it "should render a tab for the master list" do
      render
      rendered.should have_selector(:a, :content => "Tasks")
    end

    it "should render a tab for the current list" do
      render
      rendered.should have_selector(:a, :content => "Today")
    end

    it "should render a tab for the days's pomdoros" do
      render
      rendered.should have_selector(:a, :content => "Pomodoros")
    end
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
end
