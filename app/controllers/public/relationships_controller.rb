class Public::RelationshipsController < ApplicationController

  def create
    @member = Member.find(params[:member_id])
    current_member.follow(@member.id)
    @member.create_notification_follow!(current_member)
  end

  def destroy
    @member = Member.find(params[:member_id])
    current_member.unfollow(@member.id)

  end

  def followings
    @member = Member.find(params[:member_id])
    @members = @member.followings.page(params[:page]).per(10)
  end

  def followers
    @member = Member.find(params[:member_id])
    @members = @member.followers.page(params[:page]).per(10)
  end


end
