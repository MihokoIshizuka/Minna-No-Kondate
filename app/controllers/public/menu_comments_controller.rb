class Public::MenuCommentsController < ApplicationController

  def create
    @menu = Menu.find(params[:menu_id])
    @menu_comment = current_member.menu_comments.new(menu_comment_params)
    @menu_comment.menu_id = @menu.id
    if @menu_comment.save
      @menu.create_notification_menu_comment!(current_member, @menu_comment.id)
    else
      render 'public/menus/show'
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
