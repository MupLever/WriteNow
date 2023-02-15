class MatchesController < ApplicationController
  before_action :no_authentication, only: %i[new create]
  def create; end
  def show
    
  end

  def index
    matches = Match.all.to_a.select {|elem| elem.users.include?(current_user.id) }
  end

  def destroy
    @match.destroy
    flash[:success] = 'The match was successfully deleted'
  end
end
