# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :match
  belongs_to :user
  validates :content, presence: true,length: { minimum: 1 }
end
