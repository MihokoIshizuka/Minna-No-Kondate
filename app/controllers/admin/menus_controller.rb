class Admin::MenusController < ApplicationController
  before_action :authenticate_admin!

  def index
    @morning_menus = params[:tag_id].present? ? Tag.find(params[:tag_id]).menus.where(time_zone: 0).order(created_at: :desc) : Menu.where(time_zone: 0).order(created_at: :desc)
    @noon_menus = params[:tag_id].present? ? Tag.find(params[:tag_id]).menus.where(time_zone: 1).order(created_at: :desc) : Menu.where(time_zone: 1).order(created_at: :desc)
    @evening_menus = params[:tag_id].present? ? Tag.find(params[:tag_id]).menus.where(time_zone: 2).order(created_at: :desc) : Menu.where(time_zone: 2).order(created_at: :desc)
    @snack_menus = params[:tag_id].present? ? Tag.find(params[:tag_id]).menus.where(time_zone: 3).order(created_at: :desc) : Menu.where(time_zone: 3).order(created_at: :desc)
  end

  def show
    @menu = Menu.find(params[:id])
    @menu_comment = MenuComment.new
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    if @menu.update(menu_params)
      redirect_to admin_menu_path(@menu), notice: "献立情報を更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    if @menu.destroy
      redirect_to admin_member_path(@menu.member), notice: "献立を削除しました"
    else
      render 'edit'
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:date, :body, :menu_image, :time_zone, tag_ids: [])
  end

end
