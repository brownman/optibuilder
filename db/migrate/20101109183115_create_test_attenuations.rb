class CreateTestAttenuations < ActiveRecord::Migration
  def self.up
    create_table :test_attenuations do |t|
      t.integer :fiber_id
      t.integer :test_type, :limit => 1
      t.decimal :ab_injected, :precision => 8, :scale => 4
      t.decimal :ab_rcv_opt_power, :precision => 8, :scale => 4
      t.decimal :ab_opt_link_loss, :precision => 8, :scale => 4
      t.decimal :ba_injected, :precision => 8, :scale => 4
      t.decimal :ba_rcv_opt_power, :precision => 8, :scale => 4
      t.decimal :ba_opt_link_loss, :precision => 8, :scale => 4
      t.decimal :mean_loss, :precision => 8, :scale => 4
      t.timestamp :test_timestamp
      t.string :equipment, :limit => 50
      t.string :technique, :limit => 50
      t.integer :lambda, :limit => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :test_attenuations
  end
end
