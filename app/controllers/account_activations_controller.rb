class AccountActivationsController < ApplicationController

  def edit
    # golfer = User.find_by(email: params[:email]) 
    str = params[:email]
    golfer = Golfer.find_by(email: str) 
    if golfer and !golfer.activated? && golfer.authenticated?(:activation, params[:id])
    	golfer.activate
      log_in golfer
      flash[:success] = "Account activated!"
      redirect_to golfer
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
