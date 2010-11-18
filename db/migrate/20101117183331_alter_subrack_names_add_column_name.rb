class AlterSubrackNamesAddColumnName < ActiveRecord::Migration
  def self.up
    remove_column :subrack_names, :subrack_name
    add_column :subrack_names, :name, :string, :limit => 20
  end

  def self.down
    add_column :subrack_names, :subrack_name, :string, :limit => 20
    remove_column :subrack_names, :name
  end
end
