class Public::ChatsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_correct_member, only: [:index, :create, :destroy]

  def index
    @group = Group.find(params[:group_id])
    @chats = @group.chats.all
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to request.referer
    else
      redirect_to request.referer, notice: "メッセージの作成に失敗しました"
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to request.referer, notice: "メッセージを削除しました"
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
