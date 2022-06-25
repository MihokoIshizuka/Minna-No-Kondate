class Public::NotificationsController < ApplicationController

  def index
    notifications = current_member.passive_notifications

    # まだ確認していない通知のみ
    notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
    @notifications = notifications.where.not(visiter_id: current_member.id)

  end

  def destroy_all
    @notifications = current_member.passive_notifications.destroy_all
    redirect_to member_notifications_path(current_member)
  end
end
