class DrillsController < ApplicationController

  # Get the desired drill for the show, edit,
  # update, and destroy actions before they execute
  before_action :get_drill, only: [:show, :edit, :update, :destroy]

  def index
    @drills = Drill.order(created_at: :desc)
  end

  def new
    @drill = Drill.new
  end

  def create
    @drill = Drill.new drill_params
    if @drill.save
      redirect_to @drill, notice: "Drill successfully created!"
    else
      flash[:alert] = get_errors
      render :new
    end
  end

  def show
    @solutions = @drill.solutions
  end

  def edit
  end

  def update
    if @drill.update drill_params
      redirect_to @drill, notice: "Drill successfully updated!"
    else
      flash[:alert] = get_errors
      render :edit
    end
  end

  def destroy
    if @drill.destroy
      redirect_to drills_path, notice: "Drill successfully deleted!"
    else
      flash[:alert] = get_errors
      redirect_to @drill
    end
  end

  private

  def get_drill
    @drill = Drill.find params[:id]
  end

  def drill_params
    params.require(:drill).permit(:title, :description)
  end

  def get_errors
    @drill.errors.full_messages.join('; ')
  end

end
