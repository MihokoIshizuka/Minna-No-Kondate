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
  validate :menu_image_type


  enum time_zone: { morning: 0, noon: 1, evening: 2, snack: 3 }
  def menu_image_type
    # menu_imageのデータが空の時は処理を抜ける
    if menu_image.blob.nil?
      errors.add(:menu_image, 'が入力されていません。')
      return
    end
    if !menu_image.blob.content_type.in?(%('image/jpeg image/png'))
      errors.add(:menu_image, 'はjpegまたはpng形式でアップロードしてください')
    end
  end

  def get_menu_image(width, height)
    menu_image.variant(resize_to_fill: [width, height]).processed
  end


  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  def create_notification_by(current_member)
    # 通知の中から自分がしたいいねを探す＝同じ投稿に何度いいねしても通知は1回にする
    temp = Notification.where(["visiter_id = ? and visited_id = ? and menu_id = ? and action = ? ", current_member.id, member_id, id, 'favorite'])
    if temp.blank?
      notification = current_member.active_notifications.new(
        menu_id: id,
        visited_id: member_id,
        action: 'favorite'
      )
    # 自分の投稿へのいいねは通知済とする
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_menu_comment!(current_member, menu_comment_id)
    # 投稿者に通知を送る
    if self.member_id != current_member.id
      save_notification_menu_comment!(current_member, menu_comment_id, member_id)
    end
  end

  def save_notification_menu_comment!(current_member, menu_comment_id, visited_id)
    # コメントは複数回することもあるため、１つの投稿に複数回通知する
    notification = current_member.active_notifications.new(
      menu_id: id,
      menu_comment_id: menu_comment_id,
      visited_id: visited_id,
      action: 'menu_comment'
    )
    # 自分の投稿に対するコメントは通知済とする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
