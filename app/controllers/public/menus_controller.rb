class Public::MenusController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.member_id = current_member.id
    if @menu.save
      redirect_to member_path(current_member), notice: "献立を投稿しました"
    else
      render 'new'
    end
  end

  def index
    @menus = Menu.all
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    if @menu.update(menu_params)
      redirect_to menu_path(@menu), notice: "献立情報が更新されました"
    else
      render 'edit'
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    if @menu.destroy
      redirect_to member_path(current_member)
    else
      render 'edit'
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:date, :body, :menu_image)
  end

end
