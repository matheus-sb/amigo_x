class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper_method :groups_by_user
  
  def groups_by_user
    Group.joins(:participants).distinct.where('participants.user_id = ?', current_user.id)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
     devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
