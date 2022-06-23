class Public::GroupsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_correct_member, only: [:edit, :update]

  def index
    @groups = Tag.search_group_on_tags(params[:tag_id]).page(params[:page]).per(8)
  end

  def show
    @group = Group.find(params[:id])
    @members = @group.members.page(params[:page]).per(6).order(created_at: :desc)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_member.id
    @group.members << current_member
    if @group.save
      redirect_to groups_path, notice: "グループを作成しました"
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path, notice: "グループ情報を更新しました"
    else
      render 'edit'
    end
  end
  # グループ退会
  def destroy
    @group = Group.find(params[:id])
    @group.members.destroy(current_member)
    redirect_to group_path(@group)
  end
  # グループ参加
  def join
    @group = Group.find(params[:group_id])
    @group.members << current_member
    redirect_to group_path(@group)
  end
  # グループ削除
  def all_destroy
    @group = Group.find(params[:group_id])
    if @group.destroy
      redirect_to groups_path, notice: "グループを削除しました"
    else
      render 'edit'
    end
  end


  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image, tag_ids: [])
  end

  def ensure_correct_member
    @group = Group.find(params[:id])
    unless @group.owner_id == current_member.id
      redirect_to groups_path
    end
  end
end
