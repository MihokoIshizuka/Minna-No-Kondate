class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_member.passive_notifications

    # まだ確認していない通知のみ
    @notifications.where(checked: false).update_all(checked: true)

  end

  def destroy_all
    @notifications = current_member.passive_notifications.destroy_all
    redirect_to member_notifications_path(current_member)
  end
end
