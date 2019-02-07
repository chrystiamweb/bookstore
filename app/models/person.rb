class Person < ApplicationRecord
    include ActiveModel::Serializers::Xml

    has_secure_password

    validates :password, presence: { on: :create }, 
    length:{
        minimum: 8 , allow_blank: true
    }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, allow_blank: true, allow_nil: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_.-]+@([a-zA-Z0-9_-]+\.)+[a-zA-Z]{2,4}\z/}
    validates :born_at, presence: true
    validate :age_limit

    before_save :convert_email

    private 

    def age_limit
        if self.born_at.nil? || Date.current.year - self.born_at.year < 16
            errors.add(:born_at, 'Need to be older than 16 years')
            throw(:abort)
        end
    end
    
    def convert_email
        self.email = email.downcase
    end
end
