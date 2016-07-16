class ChatRoomsController < ApplicationController
  before_action: :authenticate_user!
  before_action: :set_group, only: :show

  def show
    @chat_room = ChatRoom.includes(:messages).find_by_group(@group)
  end

  private
  
  def set_group      
    @group = Group.where({id: params[:group_id], user_id: current_user}).take;
    redirect_to groups_url if @group.blank?
  end  
end