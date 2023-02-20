# frozen_string_literal: true

class MatchesController < ApplicationController
  before_action :receive_before, only: :show
  before_action :no_authentication, only: %i[new create]
  before_action :authentication, only: %i[index show]

  def create; end

  def show
    @messages = @match.messages

    @message = Message.new
  end

  def index
    @matches = current_user.matches.includes(:users)
  end

  def receive_before
    @match = Match.find params[:id]
  end
end
