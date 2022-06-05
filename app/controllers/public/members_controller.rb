class Public::MembersController < ApplicationController
  before_action :authenticate_member!, except: [:index,]

  def index
    @members = Member.where(is_deleted: false)
  end

  def show
    @member = Member.find(params[:id])
    @menus = @member.menus
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

  private
  def member_params
    params.require(:member).permit(:name, :introduction, :profile_image)
  end


end
