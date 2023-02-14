class User < ApplicationRecord
    has_secure_password

    has_many :matchs, dependent: :destroy

    validates :email, presence: true, uniqueness: true, length: { minimum: 6 }
    validates :name, presence: true, length: { minimum: 5 }
    validates :surname, presence: true, length: { minimum: 5 }
end
