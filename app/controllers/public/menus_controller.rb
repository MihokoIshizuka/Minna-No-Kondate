class Public::MenusController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]
  before_action :correct_member, only: [:edit, :update, :destroy]

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
    @morning_menus = Tag.search_menu_on_tags(params[:tag_id], 0).page(params[:morning_menus]).per(12)
    @noon_menus = Tag.search_menu_on_tags(params[:tag_id], 1).page(params[:noon_menus]).per(12)
    @evening_menus = Tag.search_menu_on_tags(params[:tag_id], 2).page(params[:evening_menus]).per(12)
    @snack_menus = Tag.search_menu_on_tags(params[:tag_id], 3).page(params[:snack_menus]).per(12)
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
      redirect_to menu_path(@menu), notice: "献立情報を更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    if @menu.destroy
      redirect_to member_path(current_member), notice: "献立を削除しました"
    else
      render 'edit'
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:date, :body, :menu_image, :time_zone, tag_ids: [])
  end

  def correct_member
    @menu = Menu.find(params[:id])
    @member = @menu.member
    redirect_to menu_path(@menu) unless @member == current_member
  end

end
