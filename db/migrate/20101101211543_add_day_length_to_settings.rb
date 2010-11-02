class AddDayLengthToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :day_length, :integer, :default => 12
  end

  def self.down
    remove_column :settings, :day_length
  end
end
