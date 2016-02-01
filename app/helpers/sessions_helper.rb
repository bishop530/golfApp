module SessionsHelper

	# Logs in the give user
	def log_in(golfer)
		session[:golfer_id] = golfer.id
	end

	# Returns the currently logged-in user (if any)
	def current_golfer
    if(golfer_id = session[:golfer_id])
      @current_golfer ||= Golfer.find_by(id: golfer_id)
    elsif (golfer_id = cookies.signed[:golfer_id])
      golfer = Golfer.find_by(id: golfer_id)
      #if golfer && golfer.authenticated?(:remember, cookies[:remember_token])
      if golfer
        log_in golfer
        @current_golfer = golfer
      end
    end
  end

  def admin_golfer
      redirect_to(root_url) unless current_golfer.admin?
  end

  # Returns true if the given golfer is the current one
  def current_golfer?(golfer)
  	golfer == current_golfer
  end

  # Confirms a logged-in golfer
  def logged_in_golfer
    unless logged_in?
      store_location
      flash[:danger] = "You must be logged in to view or modify content. Please log in."
      redirect_to login_url
    end
  end

	# Return true if the golfer is logged in, false otherwise
	def logged_in?
		!current_golfer.nil?
	end

	# Logs out the current golfer
	def log_out
		session.delete(:golfer_id)
		@current_golfer = nil
	end

  # Redirects to stored location (or to the default).

  def redirect_back_or(default)
  	redirect_to(session[:forwarding_url] || default)
  	session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed
  def store_location
  	session[:forwarding_url] = request.url if request.get?
  end

end
