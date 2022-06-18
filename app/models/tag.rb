class Tag < ApplicationRecord
  has_many :group_tags
  has_many :groups, through: :group_tags, dependent: :destroy
  has_many :menu_tags
  has_many :menus, through: :menu_tags
  has_many :members, dependent: :destroy
  has_many :member_tags
  has_many :members, through: :member_tags

  validates :name, presence: true

  # 献立一覧のタグ絞り込み
  def self.search_menu_on_tags(tag_id, time_zone)
      # tag_idがついていたら
    if tag_id.present?
      # 献立の中からtag_idがついたもので指定されたtime_zoneのものを自分で探す
      self.find(tag_id).menus.where(time_zone: time_zone).order(created_at: :desc)
      # tag_idがなければ
    else
      # 献立から指定されたtime_zoneのものを探す
      Menu.where(time_zone: time_zone).order(created_at: :desc)
    end
  end

  # 会員詳細（指定された会員の献立一覧）のタグ絞り込み
  def self.search_menu_on_tags_myself(member_id, tag_id, time_zone)
    if tag_id.present?
      self.find(tag_id).menus.where(time_zone: time_zone, member_id: member_id).order(created_at: :desc)
    else
      Menu.where(time_zone: time_zone, member_id: member_id).order(created_at: :desc)
    end
  end

  # 会員一覧のタグ絞り込み
  def self.search_member_on_tags(tag_id)
    if tag_id.present?
      self.find(tag_id).members.order(created_at: :desc)
    else
      Member.where(is_deleted: false).order(created_at: :desc)
    end
  end

  # グループ一覧のタグ絞り込み
  def self.search_group_on_tags(tag_id)
    if tag_id.present?
      self.find(tag_id).groups.order(created_at: :desc)
    else
      Group.all.order(created_at: :desc)
    end
  end
end
