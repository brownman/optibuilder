class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :name, :limit => 30
      t.string :acronym, :limit => 10
      t.date :install_date
      t.string :notes
      t.integer :network_owner_id #Company
      t.integer :address_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
