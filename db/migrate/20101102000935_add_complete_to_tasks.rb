class AddCompleteToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :complete, :boolean, :default => false
  end

  def self.down
    remove_column :tasks, :complete
  end
end
