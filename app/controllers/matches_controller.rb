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
    @matches = current_user.matches.all
  end

  def destroy
    @match.destroy
    flash[:success] = 'The match was successfully deleted'
  end
  
  def receive_before
    @match = Match.find params[:id]
  end
end
