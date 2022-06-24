class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_member.passive_notifications
    # まだ確認していない通知のみ
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def all_destroy
    @notifications = current_member.passive_notifications.all_destroy
    redirect_to member_notifications_path(current_member)
  end
end
