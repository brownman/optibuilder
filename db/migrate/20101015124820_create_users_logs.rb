class CreateUsersLogs < ActiveRecord::Migration
  def self.up
    create_table :users_logs do |t|
      t.date :access_date
      t.time :time_using
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users_logs
  end
end
