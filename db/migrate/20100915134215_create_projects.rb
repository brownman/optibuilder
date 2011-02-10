class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.integer :customer_id #Company
      t.integer :network_owner_id #Company
      t.string :name
      t.string :description
      t.date :begin_date
      t.date :end_date
      t.string :status, :limit => 2
      t.boolean :has_test_orl, :default => false
      t.boolean :has_test_chromatic, :default => false
      t.boolean :has_test_site_survey, :default => false
      t.boolean :has_test_otdr_standard, :default => false
      t.boolean :has_test_otdr_premium, :default => false
      t.boolean :has_test_attenuation_1550, :default => false
      t.boolean :has_test_attenuation_1310, :default => false
      t.boolean :has_test_pmd_10_min, :default => false
      t.boolean :has_test_pmd_60_min, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
