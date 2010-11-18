class AlterUsersProjectsAddingRole < ActiveRecord::Migration
  def self.up
    add_column :users_projects, :role, :integer, :limit => 2
  end

  def self.down
    remove_column :users_projects, :role
  end
end
