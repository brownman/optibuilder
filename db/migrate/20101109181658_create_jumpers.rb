class CreateJumpers < ActiveRecord::Migration
  def self.up
    create_table :jumpers do |t|
      t.string :connectors, :limit => 20
      t.integer :lenght, :limit => 1
      t.string :description
      t.integer :fiber_id

      t.timestamps
    end
  end

  def self.down
    drop_table :jumpers
  end
end
