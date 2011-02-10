class CreateCables < ActiveRecord::Migration
  def self.up
    create_table :cables do |t|
      t.string :name
      t.integer :span_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cables
  end
end
