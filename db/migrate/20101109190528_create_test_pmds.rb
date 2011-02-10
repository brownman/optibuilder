class CreateTestPmds < ActiveRecord::Migration
  def self.up
    create_table :test_pmds do |t|
      t.decimal :fiber_id
      t.integer :test_type, :limit => 1
      t.decimal :pmd_set1_a, :precision => 6, :scale => 2
      t.decimal :pmd_set1_b, :precision => 6, :scale => 2
      t.decimal :pmd_set1_c, :precision => 6, :scale => 2
      t.decimal :pmd_set2_a, :precision => 6, :scale => 2
      t.decimal :pmd_set2_b, :precision => 6, :scale => 2
      t.decimal :pmd_set3_c, :precision => 6, :scale => 2
      t.decimal :pmd_set3_a, :precision => 6, :scale => 2
      t.decimal :pmd_set2_b, :precision => 6, :scale => 2
      t.decimal :pmd_set3_c, :precision => 6, :scale => 2
      t.decimal :pmd_mean, :precision => 6, :scale => 2
      t.decimal :pmd_max, :precision => 6, :scale => 2
      t.decimal :pmd_std, :precision => 6, :scale => 2
      t.decimal :pmd_span, :precision => 6, :scale => 2
      t.decimal :pmd_coef, :precision => 6, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :test_pmds
  end
end
