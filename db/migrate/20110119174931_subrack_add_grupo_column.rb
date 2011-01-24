class SubrackAddGrupoColumn < ActiveRecord::Migration
  def self.up
    add_column :subracks, :grupo, :string, :limit => 5
  end

  def self.down
    remove_column :subracks, :grupo
  end
end
