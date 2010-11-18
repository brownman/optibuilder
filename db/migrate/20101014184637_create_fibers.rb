class CreateFibers < ActiveRecord::Migration
  def self.up
    create_table :fibers do |t|
      t.integer :number
      t.integer :status
      t.integer :span_id
      t.integer :fiber_end_id
      t.integer :subrack_name_id
      t.boolean :jumper

      t.timestamps
    end
  end

  def self.down
    drop_table :fibers
  end
end
