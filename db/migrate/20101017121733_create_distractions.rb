class CreateDistractions < ActiveRecord::Migration
  def self.up
    create_table :distractions do |t|
      t.string :type
      t.integer :pomodoro_id

      t.timestamps
    end
  end

  def self.down
    drop_table :distractions
  end
end
