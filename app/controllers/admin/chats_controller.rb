class Admin::ChatsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @group = Group.find(params[:group_id])
    @chats = @group.chats.all
  end

  def create
    @chat = Chat.new(chat_params)
    @group = Group.find(params[:group_id])
    @chat.group.id = @group.id
    @chat.admin_id = current_admin.id
    unless @chat.save
      @chats = @group.chats.all
      render 'index', alert: "メッセージの作成に失敗しました"
    end
    @chats = @group.chats.all
  end

  def destroy
    @group = Group.find(params[:group_id])
    Chat.find(params[:id]).destroy
    @chats = @group.chats.all
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :image, :group_id).merge(admin_id: current_admin.id)
  end
end
