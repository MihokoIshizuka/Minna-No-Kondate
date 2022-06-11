class Admin::MenuCommentsController < ApplicationController
  before_action :authenticate_admin!

  def create
    @menu = Menu.find(params[:menu_id])
    @menu_comment = MenuComment.new(menu_comment_params)
    @menu_comment.menu_id = @menu.id
    @menu_comment.admin_id = current_admin.id
    unless @menu_comment.save
      render 'admin/menus/show'
    end
  end

  def destroy
    @menu = Menu.find(params[:menu_id])
    @menu_comment = MenuComment.find(params[:id])
    @menu_comment.destroy
  end

  private

  def menu_comment_params
    params.require(:menu_comment).permit(:comment)
  end
end
