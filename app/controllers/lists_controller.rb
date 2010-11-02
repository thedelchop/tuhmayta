class ListsController < ApplicationController
  before_filter :authenticate_user!

  def sort
    @list = List.find(params[:id])

    params[:task].each_with_index do |id, index|
      @list.list_tasks.update_all(['position=?', index+1], ['task_id=?', id])
    end

    render :nothing => true
  end

  def add
    @list = List.find(params[:id])

    # Find the list-task entry for the task and then change the list to its new list
    @list_task = ListTask.where(:task_id => params[:task_id]).first 

    @list_task.list = @list

    @list_task.save

    render :nothing => true
  end

  def show
    if params[:name] == "current"
      @list = current_user.current_list
    else
      @list = current_user.master_list
      #Then we should sort the list based on position
      @list.list_tasks.sort!{|a,b| a.position <=> b.position}
    end


    render :layout => false
  end

  def index
  end
end
