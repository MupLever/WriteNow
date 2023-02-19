# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :match
  belongs_to :user
  validates :content, length: { minimum: 6 }
end
