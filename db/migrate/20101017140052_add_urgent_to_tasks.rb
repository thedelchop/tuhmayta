class AddUrgentToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :urgent, :boolean
  end

  def self.down
    remove_column :tasks, :urgent
  end
end
