class User < ApplicationRecord
    has_secure_password

    has_many :reviews
    has_many :restaurants

    validates_uniqueness_of :email
    validates_presence_of :name, :email, :password,
    validates_uniqueness_of :email
    validates :password, length: { in: 6..20 }
    

    def self.find_or_create_from_omniauth(access_token)
        User.find_or_create_by(email: access_token.info.email) do |u|
            u.name = access_token.info.first_name
            u.password = SecureRandom.hex(12)
        end
    end
    
end
