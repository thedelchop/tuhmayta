class ListsController < ApplicationController
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
end
