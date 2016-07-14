class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:edit, :update, :destroy]
  before_action :set_group_show, only: :show
  before_action :set_group_with_participants, only: :raffle

  # GET /groups
  def index
    @groups = groups_by_user
  end

  # GET /groups/1
  def show
    @participant = Participant.new
  end

  # GET /groups/new
  def new
    @group = current_user.groups.build
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  def create
    @group = current_user.groups.build(group_params)
    participant = @group.participants.build(email: current_user.email)
    participant.user = @group.user
    
    if @group.save
      redirect_to @group, notice: 'Grupo criado com sucesso'
    else
      render :new
    end  
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Grupo atualizado com sucesso'
    else
      render :edit
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Groupo deletado com sucesso'
  end

  def raffle
    msg = 'Sorteio realizado com sucesso! ;)'
    begin
      @group.raffle;
    rescue => e
      msg = e
    end    
    redirect_to @group, notice: msg
  end

  def secret_friend
    @participant = Participant.where({group_id: params[:id], user_id: current_user}).take

    redirect_to groups_url if @participant.blank?
  end

  def messages
    # todo
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group      
      @group = Group.where({id: params[:id], user_id: current_user}).take;

      redirect_to groups_url if @group.blank?
    end

    def set_group_show
      @group = Group.joins(:participants).distinct.where('groups.id = ? AND participants.user_id = ?', params[:id], current_user.id).take

      redirect_to groups_url if @group.blank?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :address, :city)
    end

    def set_group_with_participants
      @group = Group.includes(:participants).where({id: params[:id], user_id: current_user}).take;

      redirect_to groups_url if @group.blank?
    end
end