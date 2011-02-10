class CreateDiagrams < ActiveRecord::Migration
  def self.up
    create_table :diagrams do |t|
      t.string :name, :limit => 20
      t.integer :subracks_qty
      t.integer :subracks_rows
      t.integer :subracks_cols

      t.timestamps
    end
  end

  def self.down
    drop_table :diagrams
  end
end
