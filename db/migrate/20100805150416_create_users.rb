class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :limit => 50
      t.string :login, :limit => 20
      t.string :email, :limit => 50
      t.string :hashed_password, :limit => 100
      t.string :salt, :limit => 100
      t.date :expiration
      t.integer :status, :limit => 1
      t.integer :company_id
      t.string :company_description, :limit => 20
      t.string :contact_phone, :limit => 20
      t.string :comments, :limit => 20

      t.timestamps
    end

    User.create(
      :name => "System Administrator",
      :login => "admin",
      :password => "admin",
      :email => "admin@optibuilder.net",
      :expiration => Date.today.>>(3),
      :status => 1,
      :company_id => 1,
      :company_description => "Fiberwork Campinas",
      :contact_phone => "+ 55 (19) 3296 0583",
      :comments => "No comments"
    )
    say "== Adding Administrator User. user: 'admin' password: 'admin' Expire in " + Date.today.>>(3).strftime("%Y-%m-%d")
  end

  def self.down
    drop_table :users
  end
end
