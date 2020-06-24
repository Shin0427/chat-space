class MessagesController < ApplicationController

  before_action :set_group
  before_action :group_name
  before_action :member_list
  # 最初にグループを特定する

  # ↓メッセージを最初に表示する
  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)
  end

  def group_name
    @group = Group.find(params[:group_id])
  end

  def member_list
    @member_list = Group.find(params[:group_id]).users.flat_map(&:name)
  end


  def create
    @message = @group.messages.new(message_params)
    if @message.save
      
      respond_to do |format|
        format.json
      end

      # binding.pry
      # redirect_to group_messages_path(@group), notice: 'メッセージが送信されました'
    else
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
  end


  private
  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  
end
