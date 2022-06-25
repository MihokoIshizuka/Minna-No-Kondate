module Public::NotificationsHelper

  def notification_form(notification)
    @visiter = notification.visiter
    @menu_comment = nil
    your_menu = link_to 'あなたの投稿', menu_path(notification), style:"font-weight: bold;"
    @visiter_menu_comment = notification.menu_comment_id
    # actionがfollowかfavoriteかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visiter.name, href:member_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
      when "favorite" then
        tag.a(notification.visiter.name, href:member_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:menu_path(notification.menu_id), style:"font-weight: bold;")+"にいいねしました"
      when "menu_comment" then
        @menu_comment = MenuComment.find_by(id: @visiter_menu_comment)&.content
        tag.a(@visiter.name, href:member_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:menu_path(notification.menu_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_member.passive_notifications.where(checked: false)
  end
end
