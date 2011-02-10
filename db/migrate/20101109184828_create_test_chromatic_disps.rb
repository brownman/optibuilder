class CreateTestChromaticDisps < ActiveRecord::Migration
  def self.up
    create_table :test_chromatic_disps do |t|
      t.integer :fiber_id
      t.decimal :dsp_lambda_z, :precision => 22, :scale => 10
      t.decimal :dsp_1310, :precision => 22, :scale => 10
      t.decimal :dsp_1525, :precision => 22, :scale => 10
      t.decimal :dsp_1530, :precision => 22, :scale => 10
      t.decimal :dsp_1540, :precision => 22, :scale => 10
      t.decimal :dsp_1550, :precision => 22, :scale => 10
      t.decimal :dsp_1560, :precision => 22, :scale => 10
      t.decimal :dsp_1570, :precision => 22, :scale => 10
      t.decimal :dsp_1575, :precision => 22, :scale => 10
      t.decimal :dsp_1625, :precision => 22, :scale => 10
      t.decimal :dsp_total, :precision => 22, :scale => 10
      t.decimal :dsp_slopezero, :precision => 22, :scale => 10
      t.decimal :dsp_slopeother, :precision => 22, :scale => 10
      t.decimal :dsp_coef_a, :precision => 33, :scale => 16
      t.decimal :dsp_coef_b, :precision => 33, :scale => 16
      t.decimal :dsp_coef_c, :precision => 33, :scale => 16
      t.timestamp :test_timestamp

      t.timestamps
    end
  end

  def self.down
    drop_table :test_chromatic_disps
  end
end
