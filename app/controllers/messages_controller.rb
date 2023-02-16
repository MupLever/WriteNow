class MessagesController < ApplicationController
    before_action :recieve_match

    def create
        message = @match.messages.build recieve_params_for_new
        
        redirect_to match_path(@match) if message.save
    end

    def recieve_params_for_new
        params.require(:message).permit(:content).merge(user_id: current_user.id)
    end

    def recieve_match
        @match = Match.find params[:match_id]
    end
end
