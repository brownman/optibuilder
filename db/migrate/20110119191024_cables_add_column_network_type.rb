class CablesAddColumnNetworkType < ActiveRecord::Migration
  def self.up
    add_column :cables, :network_type, :string, :limit => 20
  end

  def self.down
    remove_column :cables, :network_type
  end
end
