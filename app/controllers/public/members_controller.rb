class Public::MembersController < ApplicationController

  def index
    @members = Member.all
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

  end

  private
  def member_params
    params.require(:member).permit(:name, :introduction, :profile_image)
  end


end
