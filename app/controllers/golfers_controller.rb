class GolfersController < ApplicationController
	before_action :logged_in_golfer, only: [:index, :edit, :update, :destroy]
  before_action :correct_golfer,   only: [:edit, :update]
  before_action :admin_golfer,     only: :destroy

	def new
		@golfer = Golfer.new
	end

	def index
    @golfers = Golfer.all.order('name asc')
    #@golfers = Golfer.all.order('name asc').paginate(page: params[:page], per_page: 10)
		#@golfers = Golfer.select(:name).distinct.order('name asc')
		#@golfers = Golfer.find_by_sql("select * from golfers group by name order by name ASC")
	end

	def show
		@golfer = Golfer.find(params[:id])
		#@scores = Golfer.where("name = ?", @golfer.name)
	end

	def create
  	@golfer = Golfer.new(golfer_params)
  	if @golfer.save
      @golfer.send_activation_email
      flash[:info] = "Please check your email to activate your account."
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  def edit
    @golfer = Golfer.find(params[:id])
  end

  def update
    @golfer = Golfer.find(params[:id])
    if @golfer.update_attributes(golfer_params)
      flash[:success] = 'Profile was successfully updated.'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    Golfer.find(params[:id]).destroy
    flash[:success] = "Golfer successfully deleted."
    redirect_to golfers_path
  end


private
	
	def golfer_params
		params.require(:golfer).permit(:name, :email, :password, :password_confirmation)
	end

  # Before filters

  # Confirms a logged-in golfer
  def logged_in_golfer
    unless logged_in?
      store_location
      flash[:danger] = "You must be logged in to view or modify content. Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct golfer
  def correct_golfer
    @golfer = Golfer.find(params[:id])
    redirect_to(root_url) unless @golfer == current_golfer
  end

  def admin_golfer
      redirect_to(root_url) unless current_golfer.admin?
  end

end
