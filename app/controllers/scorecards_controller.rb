class ScorecardsController < ApplicationController
  before_action :get_drill_group
  # Gets the scorecard id for edit, update
  # and destroy actions before execution

  before_action :get_scorecard, only: [:edit, :update, :destroy]
  
  def index
    @scorecards = Scorecard.order(created_at: :desc)
  end

  def create
    @scorecard = Scorecard.new scorecard_params
    if @scorecard.save
      redirect_to [@drill_group, @scorecard]
    else
      flash[:alert] = get_errors
      render: :new
    end
  end
  
  def edit
  end
  
  def update
    if @scorecard.update scorecard_params
      redirect_to [@drill_group, @scorecard]
    else
      flash[:alert] = get_errors
      render :edit
    end
  end
  
  def destroy
    if @scorecard.destroy
      redirect_to drill_group_scorecards_path(@drill_group)
    else
      flash[:alert] = get_errors
      redirect_to [@drill_group, @scorecard]
    end
  end

  private

  def get_drill_group
    @drill_group = DrillGroup.find params[:drill_group_id]
  end

  def get_scorecard
    @scorecard = Scorecard.find params[:id]
  end

  def scorecard_params
    params.require(:scorecard).permit(:user_id, :drill_group_id, :total_drills, :correct_drills)
  end

  def get_errors
    @scorecard.errors.full_messages.join('; ')
  end

end