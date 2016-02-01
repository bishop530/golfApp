class SessionsController < ApplicationController

  def new
  end

  def create
  	golfer = Golfer.find_by(email: params[:session][:email].downcase)
  	if golfer && golfer.authenticate(params[:session][:password])
      if golfer.activated?
  		  log_in golfer
        redirect_back_or root_path
      else
        message = 'Account not activated. '
        message += 'Check your email for the activation link.'
        flash[:warning] = message
        redirect_to root_url
      end
  	else
  		flash.now[:danger] = 'Invalid email/password combinaton'
  		render 'new'
  	end
  end

  def destroy
  	log_out if logged_in?
  	flash[:success] = "You have been successfully logged out."
  	redirect_to root_url
  end

end