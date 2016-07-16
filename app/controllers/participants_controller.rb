class ParticipantsController < ApplicationController  
  before_action :authenticate_user!
  before_action :set_group, only: [:new, :create]
  before_action :set_participant, only: :destroy

  def show
  end

  def create
    @participant = @group.participants.build(participant_params)

    respond_to do |format|
      if @participant.save
        ParticipantMailer.participant_confirmation(@participant).deliver
        format.js { render action: 'show', status: :created, location => [@grupo, @participant] }
      else
        format.js { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @participant.destroy
    redirect_to group_path(params[:group_id])
  end	

  def confirm
    participant = Participant.find_by_confirm_token(params[:id])
    
    if participant && participant.email == current_user.email
      participant.confirm_participation(current_user)
      redirect_to participant.group, notice: 'Bem vindo, obrigado pela sua confirmação'
    else
      redirect_to groups_path, notice: 'Houve um problema na confirmação, Verifique se ao logar você utilizou o mesmo e-mail que foi enviado'
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:group_id])

      redirect_to groups_url if @group.blank?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
    end    

    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.require(:participant).permit(:email)
    end  
end
