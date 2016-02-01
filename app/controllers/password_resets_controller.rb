class PasswordResetsController < ApplicationController
	before_action :get_golfer,          only: [:edit, :update]
	before_action :valid_golfer,        only: [:edit, :update]
	before_action :check_expiration,    only: [:edit, :update]

  def new
  end

  def create
  	@golfer = Golfer.find_by(email: params[:password_reset][:email].downcase)
  	if @golfer
  	  @golfer.create_reset_digest
  	  @golfer.send_password_reset_email
  	  flash[:info] = "Email sent with password reset instructions"
  	  redirect_to root_url
  	else
  		flash[:danger] = "Email address not found"
  		render 'new'
    end
  end

  def edit
  end

  def update
  	if password_blank?
  		flash.now[:danger] = "Password cannot be blank"
  		render 'edit'
  	elsif @golfer.update_attributes(golfer_params)
  		log_in @golfer
  		flash[:success] = "Password as been reset"
  		redirect_to @golfer
  	else
  		render 'edit'
  	end
  end

private

	def golfer_params
		params.require(:golfer).permit(:password, :password_confirmation)
	end

	# Return tru if the password is blank
	def password_blank?
		params[:golfer][:password].blank?
	end

	# Before filters
	
	def get_golfer
		str = params[:email]
		@golfer = Golfer.find_by(email: str)
	end

	# Confirm valid golfer
	def valid_golfer
		unless (@golfer && @golfer.activated? && @golfer.authenticated?(:reset, params[:id]))
			redirect_to root_url
		end
	end

	# Checks expiration of reset token
	def check_expiration
		if @golfer.password_reset_expired?
			flash[:danger] = "Password reset has expired"
			redirect_to new_password_reset_url
		end
	end

end
