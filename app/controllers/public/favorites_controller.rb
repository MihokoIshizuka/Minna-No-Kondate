class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!

  def create
    favorite = Favorite.new(member_id: current_member.id, menu_id: params[:menu_id])
    favorite.save

  end

  def destroy
    favorite = Favorite.find_by(member_id: current_member.id, menu_id: params[:menu_id])
    favorite.destroy

  end
end
