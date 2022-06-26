class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!

  def create
    @menu = Menu.find(params[:menu_id])
    favorite = current_member.favorites.new(menu_id: @menu.id)
    if @menu.member_id != current_member.id
      @menu.create_notification_by(current_member)
    end
    favorite.save
  end

  def destroy
    @menu = Menu.find(params[:menu_id])
    favorite = current_member.favorites.find_by(menu_id: @menu.id)
    favorite.destroy

  end
end
