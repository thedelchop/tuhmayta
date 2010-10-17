class TasksController < ApplicationController

  def index
    @current_tasks = current_user.current_list.tasks
    @master_tasks = current_user.master_list.tasks
  end

  def create
    @task = current_user.tasks.new(params[:task])
    respond_to do |format|
      if @task.save
        # We also need to add it to the master list of tasks

        ListTask.create(:task => @task, :list => current_user.master_list)

        format.json {render :json => @task}
      else
        flash[:alert] = "The task couldn't be saved"
        format.html 
      end
    end
  end

  def delete
    @task = current_user.tasks.find(params[:id])
  end
end
