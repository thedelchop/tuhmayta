class TasksController < ApplicationController

  def index
    @current_tasks = current_user.current_list.list_tasks.all(:order => 'position').collect{|list_task| list_task.task} 

  end

  def create
    @task = current_user.tasks.new(params[:task])
    if @task.save
      render :json =>  {:task => {:name => @task.name, :estimate => @task.estimate, :id => @task.id}, :notice => "Task added successfully", :success => "true"}
    else
      render :json => {:errors => @task.errors, :success => "false", :notice => "There were problems saving the task"}
    end
  end

  def destroy
    begin
      @task = current_user.tasks.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
     success = "false"
     notice = "The task couldn't be deleted, there has been an error"
    else
      @task.destroy
      success = "true"
      notice = "The task was successfully deleted"
    ensure
     render :json => {:success => success, :notice => notice}
    end
  end
end
