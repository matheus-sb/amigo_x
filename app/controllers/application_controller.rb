class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :groups_by_user
  
  def groups_by_user
  	Group.joins(:participants).distinct.where('participants.user_id = ?', current_user.id)
  end
end
