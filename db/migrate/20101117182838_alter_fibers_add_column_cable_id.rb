class AlterFibersAddColumnCableId < ActiveRecord::Migration
  def self.up
    add_column :fibers, :cable_id, :integer
  end

  def self.down
    remove_column :fibers, :cable_id
  end
end
