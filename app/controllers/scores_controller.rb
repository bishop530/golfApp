class ScoresController < ApplicationController
	before_action :logged_in_golfer, only: [:create, :edit, :update, :destroy]
	before_action :set_round

	def create
		@golfer = Golfer.find(params[:score][:golfer_id])
		@score = @round.scores.build(score_params)
		@score.golfer = @golfer
		if @score.save
			#flash[:notice] = "Score has been added."
			redirect_to round_path(@round)
		else
			flash.now[:alert] = "Score was not added."
			render "new"
		end
	end

	def edit
		@score = @round.scores.find(params[:score_id])
	end

	def update
		@score = @round.scores.find(params[:id])
		if @score.update(score_params)
			flash.now[:alert] = "Score was successfully updated."
			#redirect_to [@round, @score]
			redirect_to round_path(@round)
		else
			flash.now[:alert] = "Score was not updated."
			render 'edit'
		end
	end

	def destroy
		@score = @round.scores.find(params[:score_id])
		@score.destroy
		flash[:notice] = "Score was successfully deleted."
		redirect_to @rounds
	end

private
	
	def score_params
		params.require(:score).permit(:score, :round)
	end

	def set_round
		@round = Round.find(params[:round_id])
	end
	
end
