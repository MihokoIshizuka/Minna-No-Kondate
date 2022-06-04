class Public::MenusController < ApplicationController

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new
    if @menu.save(menu_params)
      redirect_to 'show', notice: "投稿しました"
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
  end

  def destroy
  end

  private

  def menu_params
    params.require(:menu).permit(:date, :body, :menu_image)
  end

end
