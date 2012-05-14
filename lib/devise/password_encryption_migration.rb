module Devise

  module PasswordEncryptionMigration

    def valid_password?(incoming_password)
      if using_authlogic_validation?(incoming_password)

        Devise.secure_compare(authlogic_password_digest(incoming_password), self.crypted_password).tap do |validated|
          if validated
            self.password = incoming_password
            self.crypted_password = nil
            self.save(:validate => false)
          end
          validated
        end
      else
        true
      end
    end

    def using_authlogic_validation?(incoming_password)
      !Devise.secure_compare(password_digest(incoming_password), self.encrypted_password)
    end

    def authlogic_password_digest(password)
      if self.password_salt.present?
        encrypt(password,password_salt)
      end
    end

    def encrypt(password,password_salt)
      digest = "#{password}#{password_salt}"
      20.times { digest = Digest::SHA512.hexdigest(digest) }
      digest
     end

  end

end

