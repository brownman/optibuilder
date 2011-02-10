class CreateLogBooks < ActiveRecord::Migration
  def self.up
    create_table :log_books do |t|
      t.date :log_date
      t.string :notes
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :log_books
  end
end
