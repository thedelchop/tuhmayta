class CreatePomodoros < ActiveRecord::Migration
  def self.up
    create_table :pomodoros do |t|
      t.integer :task_id
      t.boolean :void

      t.timestamps
    end
  end

  def self.down
    drop_table :pomodoros
  end
end
