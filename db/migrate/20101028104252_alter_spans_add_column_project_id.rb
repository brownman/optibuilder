class AlterSpansAddColumnProjectId < ActiveRecord::Migration
  def self.up
    add_column :spans, :project_id, :integer
  end

  def self.down
    remove_column :spans, :project_id
  end
end
