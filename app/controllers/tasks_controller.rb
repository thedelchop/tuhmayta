class TasksController < ApplicationController

  def index
    @master_tasks = current_user.master_list.list_tasks.all(:order => 'position').collect{|list_task| list_task.task} 
  
    @current_tasks = current_user.current_list.list_tasks.all(:order => 'position').collect{|list_task| list_task.task} 

  end

  def create
    @task = current_user.tasks.new(params[:task])
    if @task.save
      render @task, :layout => false
    else
      flash[:alert] = "The task couldn't be saved"
    end
  end


  def delete
    @task = current_user.tasks.find(params[:id])
  end
end
