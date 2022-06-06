class Public::RelationshipsController < ApplicationController
  # ゲストユーザーはフォロー動作ができないようにする
  before_action :ensure_normal_member, only: [:create, :destroy]

  def create
    current_member.follow(params[:member_id])
    redirect_to request.referer
  end

  def destroy
    current_member.unfollow(params[:member_id])
    redirect_to request.referer
  end

  def followings
    member = Member.find(params[:member_id])
    @members = member.followings
  end

  def followers
    member = Member.find(params[:member_id])
    @members = member.followers
  end

  private
  def ensure_normal_member
    if current_member.email == 'guest@example.com'
      redirect_to members_path, alert: "ゲストユーザーのフォローはできません"
    end
  end
end
