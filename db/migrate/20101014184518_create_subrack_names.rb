class CreateSubrackNames < ActiveRecord::Migration
  def self.up
    create_table :subrack_names do |t|
      t.integer :site_id
      t.integer :subrack_seq
      t.string :subrack_name, :limit => 5
      t.string :cable, :limit => 10
      t.string :room, :limit => 5
      t.string :floor, :limit => 5
      t.string :line, :limit => 5
      t.string :rack, :limit => 5
      t.string :subrack, :limit => 5
      t.string :group, :limit => 5
      t.string :connector, :limit => 5
      t.integer :total_fibers, :limit => 1
      t.integer :released_fibers, :limit => 1
      t.integer :broken_fibers, :limit => 1
      t.string :network_type, :limit => 20
      t.integer :diagram_id #FK

      t.timestamps
    end
  end

  def self.down
    drop_table :subrack_names
  end
end
