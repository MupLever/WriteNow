# frozen_string_literal: true

class UsersMatch < ApplicationRecord
  belongs_to :user
  belongs_to :match
end
