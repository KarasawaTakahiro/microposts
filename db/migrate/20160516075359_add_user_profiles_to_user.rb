class AddUserProfilesToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile, :string
    add_column :users, :place, :string
    add_column :users, :homepage, :string
    add_column :users, :birthday, :date
  end
end
