class CreateSpans < ActiveRecord::Migration
  def self.up
    create_table :spans do |t|
      t.integer :site_a_id
      t.integer :site_b_id
      t.integer :company_id
      t.decimal :distance
      t.integer :fiber_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :spans
  end
end
