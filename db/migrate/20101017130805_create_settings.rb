class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.integer :pomodoro_time, :default => 25
      t.integer :rest_time, :default => 5
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
