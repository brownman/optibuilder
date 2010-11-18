class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name, :limit => 30
      t.string :contact, :limit => 30
      t.string :phone, :limit => 20
      t.string :fax, :limit => 20
      t.string :email, :limit => 50
      t.string :website, :limit => 50
      t.integer :address_id
      t.string :code, :limit => 20

      t.timestamps
    end

    Company.create(:name => "Fiberwork",
                :contact => "Elso",
                :phone=> "551932960583",
                :fax => "551932960583",
                :email => "contact@fiberwork.net",
                :website => "http://www.fiberwork.net",
                :address_id => 1,
                :code => "FW")
    say "== Adding Fiberwork company and address."

  end

  def self.down
    drop_table :companies
  end
end
