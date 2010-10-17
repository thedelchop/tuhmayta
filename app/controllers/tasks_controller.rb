class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks
  end

  def create
    debugger
    @task = current_user.tasks.new(params[:task])
    render :json => @task
  end
end
