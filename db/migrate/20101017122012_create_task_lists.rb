class CreateTaskLists < ActiveRecord::Migration
  def self.up
    create_table :task_lists do |t|
      t.integer :task_id
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :task_lists
  end
end
