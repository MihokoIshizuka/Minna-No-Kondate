class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!


  def index
    @members = Member.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @member = Member.find(params[:id])
    @morning_menus = Tag.search_menu_on_tags_myself(@member.id, params[:tag_id], 0).page(params[:morning_menus]).per(12)
    @noon_menus = Tag.search_menu_on_tags_myself(@member.id, params[:tag_id], 1).page(params[:morning_menus]).per(12)
    @evening_menus = Tag.search_menu_on_tags_myself(@member.id, params[:tag_id], 2).page(params[:morning_menus]).per(12)
    @snack_menus = Tag.search_menu_on_tags_myself(@member.id, params[:tag_id], 3).page(params[:morning_menus]).per(12)
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
