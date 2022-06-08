class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to admin_groups_path, notice: "グループ情報を更新しました"
    else
      render 'edit'
    end
  end
  # グループ削除
  def all_destroy
      @group = Group.find(params[:group_id])
    if @group.destroy
      redirect_to admin_groups_path, notice: "グループを削除しました"
    else
      render 'edit'
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image, tag_ids: [])
  end

end
