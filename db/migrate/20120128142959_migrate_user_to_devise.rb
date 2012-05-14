class MigrateUserToDevise < ActiveRecord::Migration
  def up
      change_table :users do |t|
           t.string :crypted_password, :null => false, :limit => 128
      end
  end

  def down
  end
end
