class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :country, :limit => 20
      t.string :state, :limit => 20
      t.string :city, :city => 30
      t.string :street, :limit => 50
      t.string :location, :limit => 20
      t.string :zip_code, :limit => 10
      t.string :complement, :limit => 20
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
    
    Address.create(
      :country => "Brazil",
      :state => "São Paulo",
      :city => "Indaiatuba",
      :street => "Alfredo da Costa Figo, 280 - Jd. Sta. Candida",
      :location => "Campinas",
      :zip_code => "13000000",
      :complement => "Fundos"
    )
    
    say "== Adding Fiberwork address and address."
    
  end

  def self.down
    drop_table :addresses
  end
end
