class Public::MenuCommentsController < ApplicationController

  def create
    @menu = Menu.find(params[:menu_id])
    @menu_comment = MenuComment.new(menu_comment_params)
    @menu_comment.member_id = current_member.id
    @menu_comment.menu_id = @menu.id
    if @menu_comment.save
      redirect_to menu_path(@menu)
    else
      redirect_to request.referer
    end
  end

  def destroy
    @menu = Menu.find(params[:menu_id])
    MenuComment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def menu_comment_params
    params.require(:menu_comment).permit(:comment)
  end

end
