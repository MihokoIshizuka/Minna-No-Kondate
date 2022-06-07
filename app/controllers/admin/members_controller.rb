class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @menus = @member.menus
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to admin_member_path(@member), notice: "登録情報を更新しました"
  end

  def out
    @member = Member.find(params[:id])
    @member.update(is_deleted: true)
    reset_session
    redirect_to admin_members_path, notice: "退会処理が実行されました"
  end
  
  
  private

  def member_params
    params.require(:member).permit(:name, :introduction, :email, :is_deleted)
  end

end
