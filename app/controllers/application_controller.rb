class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protected

  def after_sign_in_path_for(resource)
   root_path
  end

  def authorize_staff!
    if current_user.role != 'Staff' || current_user.role != 'Coach'
      redirect_to goals
      # send to 404 message
    end
  end

end
