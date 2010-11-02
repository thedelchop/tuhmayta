class AddLongRestIntervalToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :long_rest_interval, :integer, :default => 4
  end

  def self.down
    remove_column :settings, :long_rest_interval
  end
end
