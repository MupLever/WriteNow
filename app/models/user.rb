# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :users_matches
  has_many :messages
  has_many :matches, through: :users_matches

  validates :email, presence: true, uniqueness: true, length: { minimum: 6 }
  validates :name, presence: true, length: { minimum: 2 }
  validates :surname, presence: true, length: { minimum: 2 }
end
