class Admin::MenusController < ApplicationController
  before_action :authenticate_admin!


  def index
    @menus = Menu.all
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
      redirect_to admin_menu_path(@menu), notice: "献立情報が更新されました"
    else
      render 'edit'
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    if @menu.destroy
      redirect_to admin_member_path(@menu.member)
    else
      render 'edit'
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:date, :body, :menu_image)
  end

end
