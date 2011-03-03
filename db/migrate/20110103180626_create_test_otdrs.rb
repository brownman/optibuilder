class CreateTestOtdrs < ActiveRecord::Migration
  def self.up
    create_table :test_otdrs do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :test_otdrs
  end
end
