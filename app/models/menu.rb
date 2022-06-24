class Menu < ApplicationRecord
  has_one_attached :menu_image

  belongs_to :member
  has_many :menu_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :menu_tags
  has_many :tags, through: :menu_tags, dependent: :destroy
  has_many :notifications, dependent: :destroy



  validates :date, presence: true
  validates :body, presence: true
  validates :menu_image, presence: true
  validates :tag_ids, presence: true

  enum time_zone: { morning: 0, noon: 1, evening: 2, snack: 3 }

  def get_menu_image(width, height)
    menu_image.variant(resize_to_fill: [width, height]).processed
  end


  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  def create_notification_favorite!(current_member)
    # すでにいいねされているかを確認する
    temp = Notification.where(["visiter_id = ? and visited_id = ? and menu_id = ? and action = ?", current_member.id, member_id, id, 'favorite'])
    # いいねされていない場合にのみ通知レコードを作成する
    if temp.blank?
      notification = current_member.active_notifications.new(
        menu_id: id,
        visited_id: member_id,
        action: 'favorite'
      )
      # 自分の投稿へのいいねは通知済とする
      if notification.visiter_id == notification.visited_id
        notification.chacked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_menu_comment!(current_member, menu_comment_id)
    # 自分以外にコメントしている人を全て取得し、全員に通知を送る
    temp_ids = MenuComment.select(:member_id).where(menu_id: id).where.not(member_id: current_member.id).distinct
    temp_ids.each do |temp_id|
      save_notification_menu_comment!(current_member, menu_comment_id, temp_id['member_id'])
    end
    # まだ誰もコメントしていない場合は投稿者に通知を送る
    save_notification_menu_comment!(current_member, menu_comment_id, member_id) if temp_ids.blank?
  end

  def save_notification_menu_comment!(current_member, menu_comment_id, visited_id)
    # コメントは複数回することもあるため、１つの投稿に複数回通知する
    notification = current_member.active_notifications.new(
      menu_id: id,
      menu_comment_id: menu_comment_id,
      visited_id: visited_id,
      action: 'menu_commment'
    )
    # 自分の投稿に対するコメントは通知済とする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
