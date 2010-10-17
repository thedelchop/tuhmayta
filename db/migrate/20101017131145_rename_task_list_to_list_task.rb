class RenameTaskListToListTask < ActiveRecord::Migration
  def self.up
    rename_table :task_lists, :list_tasks
  end

  def self.down
    rename_table :list_tasks, :task_lists 
  end
end
