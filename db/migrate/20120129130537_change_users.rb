class ChangeUsers < ActiveRecord::Migration
  def up
      change_column :spree_users, :crypted_password,:string, :null => true
  end

  def down
      change_column :spree_users, :crypted_password,:string, :null => false
  end
end
