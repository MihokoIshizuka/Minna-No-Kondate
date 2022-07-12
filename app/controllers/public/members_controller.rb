class Public::MembersController < ApplicationController
  before_action :authenticate_member!, except: [:index]
  before_action :ensure_correct_member, only: [:edit, :update]

  # ゲストユーザは編集・退会動作ができないようにする
  before_action :ensure_normal_member, only: [:edit]


  def index
    @members = Tag.search_member_on_tags(params[:tag_id]).page(params[:page]).per(10)
  end

  def show
    @member = Member.find(params[:id])
    @morning_menus = Tag.search_menu_on_tags_myself(@member.id, params[:tag_id], 0).page(params[:morning_menus]).per(12)
    @noon_menus = Tag.search_menu_on_tags_myself(@member.id, params[:tag_id], 1).page(params[:noon_menus]).per(12)
    @evening_menus = Tag.search_menu_on_tags_myself(@member.id, params[:tag_id], 2).page(params[:evening_menus]).per(12)
    @snack_menus = Tag.search_menu_on_tags_myself(@member.id, params[:tag_id], 3).page(params[:snack_menus]).per(12)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to member_path(@member), notice: "会員情報を更新しました"
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
    redirect_to root_path, notice: "退会処理を実行しました"
  end

  def favorites
    @member = Member.find(params[:member_id])
    favorites = Favorite.where(member_id: @member.id).pluck(:menu_id)
    favorite_menus = Menu.find(favorites)
    @favorite_menus = Kaminari.paginate_array(favorite_menus).page(params[:page]).per(12)
  end

  private
  def member_params
    params.require(:member).permit(:name, :introduction, :profile_image, tag_ids: [])
  end

  # ゲストユーザは編集・退会動作ができないようにする
  def ensure_normal_member
    @member = Member.find(params[:id])
    if @member.email == "guest@example.com"
      redirect_to member_path(current_member), alert: "ゲストユーザーの編集はできません"
    end
  end

  def ensure_correct_member
    @member = Member.find(params[:id])
    redirect_to edit_member_path(current_member) unless @member == current_member
  end

end
