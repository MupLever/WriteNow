# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :match
  validates :body, presence: true, length: { minimum: 1 }
end
