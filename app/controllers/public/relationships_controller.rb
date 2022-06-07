class Public::RelationshipsController < ApplicationController
  # ゲストユーザーはフォロー動作ができないようにする
  before_action :ensure_normal_member, only: [:create, :destroy]

  def create
    @member = Member.find(params[:member_id])
    current_member.follow(@member.id)
  end

  def destroy
    @member = Member.find(params[:member_id])
    current_member.unfollow(@member.id)

  end

  def followings
    @member = Member.find(params[:member_id])
    @members = @member.followings
  end

  def followers
    @member = Member.find(params[:member_id])
    @members = @member.followers
  end

  private
  def ensure_normal_member
    if current_member.email == 'guest@example.com'
      render 'public/members/index', alert: "ゲストユーザーのフォローはできません"
    end
  end
end
