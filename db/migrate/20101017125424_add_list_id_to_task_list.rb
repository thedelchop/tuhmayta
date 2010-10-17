class AddListIdToTaskList < ActiveRecord::Migration
  def self.up
    add_column :task_lists, :list_id, :integer
  end

  def self.down
    remove_column :task_lists, :list_id
  end
end
