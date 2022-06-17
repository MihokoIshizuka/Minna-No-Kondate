class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @members = Member.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @member = Member.find(params[:id])
    @morning_menus = @member.menus.where(time_zone: 0).order(created_at: :desc)
    @noon_menus = @member.menus.where(time_zone: 1).order(created_at: :desc)
    @evening_menus = @member.menus.where(time_zone: 2).order(created_at: :desc)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to admin_member_path(@member), notice: "登録情報を更新しました"
  end

  def destroy
    @members = Member.all.order(created_at: :desc)
    unless Member.find(params[:id]).destroy
      render :index, notice: "削除に失敗しました"
    end
  end


  private

  def member_params
    params.require(:member).permit(:name, :introduction, :email, :is_deleted, tag_ids: [])
  end

end
