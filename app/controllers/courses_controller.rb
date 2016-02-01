class CoursesController < ApplicationController
	before_action :set_course, only: [:edit, :update, :destroy, :show]

  def new
  	@course = Course.new
  end

	def index
		@courses = Course.all.order('name asc').paginate(page: params[:page], per_page: 7)
	end

	def show
	end

	def edit
	end

	def create
  	@course = Course.new(course_params)
  	if @course.save
  		#flash[:info] = "Course was successfully added."
  		redirect_to courses_path
  	else
  		render 'new'
  	end
  end

  def update
    if @course.update(course_params)
      #flash.now[:alert] = "Course was successfully updated."
      redirect_to courses_path
    else
      flash.now[:alert] = "Course was not updated."
      render 'edit'
    end
  end

  def destroy
    @course.destroy
    #flash[:notice] = "Course was successfully deleted."
    redirect_to courses_path
  end

private
  
  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
		params.require(:course).permit(:name, :location, :par, :par_data)
	end

end
