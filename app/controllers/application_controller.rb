class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :groups_by_user
  
  def groups_by_user
  	Group.joins(:participants).distinct.where('participants.user_id = ?', current_user.id)
  end

  # before_action :load_sidebar

 #  def load_sidebar 
 #  	unless !user_signed_in?
	#   @Groups_side_bar = Group.all
	# end
 #  end
end
