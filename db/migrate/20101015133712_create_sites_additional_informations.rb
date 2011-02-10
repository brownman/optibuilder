class CreateSitesAdditionalInformations < ActiveRecord::Migration
  def self.up
    create_table :sites_additional_informations do |t|
      t.string :cable_type, :limit => 10
      t.string :fiber_type, :limit => 10
      t.string :cable_manufacturer, :limit => 20
      t.date :cable_manufacturing_date
      t.string :installer_company, :limit => 20
      t.integer :connectors_qty, :limit => 128
      t.integer :splices_qty, :limit => 128

      t.timestamps
    end
  end

  def self.down
    drop_table :sites_additional_informations
  end
end
