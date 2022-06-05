class Public::MenuCommentsController < ApplicationController

  def create
    menu = Menu.find(params[:menu_id])
    comment = MenuComment.new(menu_comment_params)
    comment.member_id = current_member.id
    if comment.save
      redirect_to menu_path(menu)
    else
      redirect_to request.referer
    end
  end

  def destroy
    MenuComment.find(params[:menu_id]).destroy
    redirect_to request.referer
  end

  private

  def menu_comment_params
    params.require(:menu_comment).permit(:comment)
  end

end
