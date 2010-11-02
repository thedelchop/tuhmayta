require 'spec_helper'

describe "lists/show.html.haml" do

  before(:each) do
    @current_user = Factory(:user)
    sign_in @current_user

    @tasks = [] 
    7.times{@tasks << Factory(:task, :user => @current_user)}
    
    @example_task = Factory(:task, :name => "example-task", :user => @current_user)
  end
end
