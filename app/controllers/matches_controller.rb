class MatchesController < ApplicationController
  before_action :before_recieve, only: :show
  before_action :in_chat_room, only: :show
  before_action :no_authentication, only: %i[new create]

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

  def in_chat_room
    # unless @match.users.include?(current_user.id)
    #   redirect_to matches_path
    # end
  end
  
  def before_recieve
    @match = Match.find params[:id]
  end
end
