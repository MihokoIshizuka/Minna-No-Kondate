class Public::MembersController < ApplicationController
  before_action :authenticate_member!, except: [:index]
  before_action :correct_member, only: [:edit, :update]

  # ゲストユーザは退会動作ができないようにする
  before_action :ensure_normal_member, only: [:out]


  def index
    @members = params[:tag_id].present? ? Tag.find(params[:tag_id]).members.order(created_at: :desc) : Member.where(is_deleted: false).order(created_at: :desc)
  end

  def show
    @member = Member.find(params[:id])
    @morning_menus = @member.menus.where(time_zone: 0).order(created_at: :desc)
    @noon_menus = @member.menus.where(time_zone: 1).order(created_at: :desc)
    @evening_menus = @member.menus.where(time_zone: 2).order(created_at: :desc)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to member_path(@member), notice: "会員情報が更新されました"
    else
      render 'edit'
    end
  end

  def quit
    @member = current_member
  end

  def out
    @member = current_member
    @member.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会処理が実行されました。"
  end

  def favorites
    @member = Member.find(params[:member_id])
    favorites = Favorite.where(member_id: @member.id).pluck(:menu_id)
    @favorite_menus = Menu.find(favorites)
  end

  private
  def member_params
    params.require(:member).permit(:name, :introduction, :profile_image, tag_ids: [])
  end

  def ensure_normal_member
    if current_member.email == 'guest@example.com'
      redirect_to menus_path, alert: "ゲストユーザーの退会はできません"
    end
  end

  def correct_member
    @member = Member.find(params[:id])
    redirect_to edit_member_path(current_member) unless @member == current_member
  end

end
