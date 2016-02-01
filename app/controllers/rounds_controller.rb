class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :edit, :update, :destroy]

  def index
    @rounds = Round.all.order('date desc')
  end

  def new
    @round = Round.new
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def create
    @course = Course.find(params[:round][:course_id])
    if @course == nil
      message = "The #{params[:round][:course_id]} course was not found."
      message += " Please add it before adding scores for it."
      flash[:warning] = message
      redirect_to new_course_path     
    else
      @round = @course.rounds.build(round_params)
      if @round.save
        flash[:info] = "Round was successfully added."
        redirect_to round_path(@round)
      else
        render 'new'
      end
    end
  end

private

  def round_params
    params.require(:round).permit(:date, :course_name)
  end

  def set_round
    @round = Round.find(params[:id])
  end

end
