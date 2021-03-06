class Public::ChatsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_correct_member, only: [:index, :create, :destroy]

  def index
    @group = Group.find(params[:group_id])
    @chats = @group.chats.all
    @chat = current_member.chats.new
  end

  def create
    @chat = current_member.chats.new(chat_params)
    @group = Group.find(params[:group_id])
    @chat.group.id = @group.id
    unless @chat.save
      @chats = @group.chats.all
      render 'index', alert: "メッセージの作成に失敗しました"
    end
    @chats = @group.chats.all
  end

  def destroy
    @group = Group.find(params[:group_id])
    @chat = Chat.find(params[:id])
    if @chat.member.id == current_member.id
      @chat.destroy
    end
    @chats = @group.chats.all
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :image, :group_id).merge(member_id: current_member.id)
  end

  def ensure_correct_member
    @group = Group.find(params[:group_id])
    unless @group.members.include?(current_member)
      redirect_to groups_path
    end
  end
end
