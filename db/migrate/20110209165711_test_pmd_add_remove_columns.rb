class TestPmdAddRemoveColumns < ActiveRecord::Migration
 def self.up
    add_column :test_pmds, :pmd_set2_c, :decimal,:precision => 6, :scale => 2
    add_column :test_pmds, :pmd_set3_b, :decimal,:precision => 6, :scale => 2
    remove_column :test_pmds, :pmd_mean
    remove_column :test_pmds, :pmd_max
    remove_column :test_pmds, :pmd_std
    remove_column :test_pmds, :pmd_span
    remove_column :test_pmds, :pmd_coef
     remove_column :test_pmds, :test_type
  end

  def self.down
    remove_column :test_pmds, :pmd_set2_c
    remove_column :test_pmds, :pmd_set3_b
    add_column :test_pmds, :pmd_mean, :decimal,:precision => 6, :scale => 2
    add_column :test_pmds, :pmd_max, :decimal,:precision => 6, :scale => 2
    add_column :test_pmds, :pmd_std, :decimal,:precision => 6, :scale => 2
    add_column :test_pmds, :pmd_span, :decimal,:precision => 6, :scale => 2
    add_column :test_pmds, :pmd_coef, :decimal,:precision => 6, :scale => 2
    add_column :test_pmds, :test_type, :limit => 1
  end
end
