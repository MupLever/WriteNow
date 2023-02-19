# frozen_string_literal: true

class Match < ApplicationRecord
  has_many :messages
  has_many :users_matches
  has_many :users, through: :users_matches
end
