class TasksController < ApplicationController

  def index
    @tasks = current_user.tasks
  end

  def create
    @task = current_user.tasks.new(params[:task])
    respond_to do |format|
      if @task.save
        format.json {render :json => @task}
      else
        flash[:alert] = "The task couldn't be saved"
        format.html 
      end
    end
  end
end
