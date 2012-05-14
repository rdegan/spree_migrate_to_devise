User.class_eval do
    
    attr_accessible :crypted_password
    
    include Devise::PasswordEncryptionMigration
end