# frozen_string_literal: true

class Match < ApplicationRecord
  has_many :messages
  belongs_to :user
end
