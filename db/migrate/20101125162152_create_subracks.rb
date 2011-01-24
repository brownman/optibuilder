class CreateSubracks < ActiveRecord::Migration
  def self.up
    drop_table :subrack_names
    create_table :subracks do |t|
      t.string :name, :limit => 20
      t.string :room, :limit => 5
      t.string :floor, :limit => 5
      t.string :line, :limit => 5
      t.string :rack, :limit => 5
      t.string :group, :limit => 5
      t.string :connector, :limit => 5
      t.integer :total_fibers, :limit => 4
      t.integer :released_fibers, :limit => 4
      t.integer :broken_fibers, :limit => 4
      t.integer :site_id, :limit => 11
      t.integer :diagram_id, :limit => 11

      t.timestamps
    end
  end

  def self.down
    drop_table :subracks
  end
end