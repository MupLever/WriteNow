class MathesController < ApplicationController


  def new; end

  def create

  end

  def show
    
  end

  def index
    matches = Match.all.include?(current_user.id)
  end

  def destroy
    @match.destroy
    flash[:success] = 'The match was successfully deleted'

  end
end
