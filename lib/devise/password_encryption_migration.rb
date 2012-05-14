module Devise

  module PasswordEncryptionMigration

    def valid_password?(incoming_password)
      if using_authlogic_validation?
        Devise.secure_compare(authlogic_password_digest(incoming_password), self.crypted_password).tap do |validated|
          if validated
            self.password = incoming_password
            self.crypted_password = nil
            self.save(:validate => false)
          end
        end
      else
        Devise.secure_compare(password_digest(incoming_password), self.encrypted_password)
      end
    end

    def using_authlogic_validation?
      self.encrypted_password.blank?
    end

    def authlogic_password_digest(password)
      if self.password_salt.present?
        Digest::SHA1.hexdigest("--#{password_salt}--#{password}--")
      end
    end

  end

end

