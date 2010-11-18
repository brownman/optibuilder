class CreateTestOrls < ActiveRecord::Migration
  def self.up
    create_table :test_orls do |t|
      t.integer :fiber_id
      t.decimal :orl_ab, :precision => 6, :scale => 2
      t.decimal :orl_ba, :precision => 6, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :test_orls
  end
end
